import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  final VoidCallback? onClose;
  final ValueChanged<String>? onCodeScanned;

  const ScanScreen({
    super.key,
    this.onClose,
    this.onCodeScanned,
  });

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen>
    with SingleTickerProviderStateMixin {
  bool _isScanMode = true;
  late AnimationController _scanLineController;
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanLineController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _handleClose() {
    widget.onClose?.call();
  }

  void _handleSubmitCode() {
    final code = _codeController.text.trim();
    if (code.isNotEmpty) {
      widget.onCodeScanned?.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // -- Header --
            _buildHeader(context),

            // -- Toggle Tabs --
            _buildToggleTabs(),

            // -- Camera / Scanner Area --
            Expanded(
              child: _isScanMode ? _buildScanView() : _buildManualView(),
            ),

            // -- Having Trouble --
            _buildHavingTrouble(),

            const SizedBox(height: 12),

            // -- Done Button --
            _buildDoneButton(),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ───────────────────────── HEADER ─────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: _handleClose,
              child: const Icon(
                Icons.close,
                color: Color(0xFF6B2FA0),
                size: 28,
              ),
            ),
          ),
          const Text(
            'EARN POINTS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── TOGGLE ─────────────────────────

  Widget _buildToggleTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            _buildTab('MANUAL', isActive: !_isScanMode, onTap: () {
              setState(() => _isScanMode = false);
            }),
            _buildTab('SCAN', isActive: _isScanMode, onTap: () {
              setState(() => _isScanMode = true);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String label,
      {required bool isActive, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF6B2FA0) : Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey.shade600,
              fontWeight: FontWeight.w700,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  // ───────────────────────── SCAN VIEW ─────────────────────────

  Widget _buildScanView() {
    return Column(
      children: [
        const Spacer(flex: 2),

        // "Move closer" tooltip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 18),
              SizedBox(width: 6),
              Text(
                'Move closer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Down arrow
        CustomPaint(
          size: const Size(16, 8),
          painter: _TrianglePainter(color: Colors.black87),
        ),

        const SizedBox(height: 8),

        // Scanner viewfinder
        LayoutBuilder(
          builder: (context, constraints) {
            final size = constraints.maxWidth * 0.75;
            return SizedBox(
              width: size,
              height: size,
              child: Stack(
                children: [
                  // Corner brackets
                  _buildCornerBrackets(size),

                  // Camera placeholder
                  Center(
                    child: Container(
                      width: size - 24,
                      height: size - 24,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white38,
                          size: 48,
                        ),
                      ),
                    ),
                  ),

                  // Animated scan line
                  AnimatedBuilder(
                    animation: _scanLineController,
                    builder: (context, child) {
                      return Positioned(
                        top: _scanLineController.value * (size - 4),
                        left: 12,
                        right: 12,
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withValues(alpha: 0.6),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        // Flash button
        GestureDetector(
          onTap: () {
            // TODO: toggle flash
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white54, width: 2),
            ),
            child: const Icon(
              Icons.flash_off,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),

        const Spacer(flex: 3),
      ],
    );
  }

  // ───────────────────────── CORNER BRACKETS ─────────────────────────

  Widget _buildCornerBrackets(double size) {
    const bracketLength = 40.0;
    const bracketWidth = 4.0;
    const color = Colors.white;

    return Stack(
      children: [
        Positioned(
          top: 0, left: 0,
          child: _cornerBracket(bracketLength, bracketWidth, color,
              top: true, left: true),
        ),
        Positioned(
          top: 0, right: 0,
          child: _cornerBracket(bracketLength, bracketWidth, color,
              top: true, left: false),
        ),
        Positioned(
          bottom: 0, left: 0,
          child: _cornerBracket(bracketLength, bracketWidth, color,
              top: false, left: true),
        ),
        Positioned(
          bottom: 0, right: 0,
          child: _cornerBracket(bracketLength, bracketWidth, color,
              top: false, left: false),
        ),
      ],
    );
  }

  Widget _cornerBracket(double length, double width, Color color,
      {required bool top, required bool left}) {
    return SizedBox(
      width: length,
      height: length,
      child: CustomPaint(
        painter: _CornerBracketPainter(
          color: color,
          strokeWidth: width,
          top: top,
          left: left,
        ),
      ),
    );
  }

  // ───────────────────────── MANUAL VIEW ─────────────────────────

  Widget _buildManualView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Enter your code manually',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _codeController,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Enter code here',
              hintStyle: TextStyle(color: Colors.grey.shade500),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white38),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF6B2FA0), width: 2),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _handleSubmitCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B2FA0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'SUBMIT',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────── HAVING TROUBLE ─────────────────────────

  Widget _buildHavingTrouble() {
    return GestureDetector(
      onTap: () {
        // TODO: having trouble action
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.info_outline,
                size: 18, color: Colors.grey.shade700),
            const SizedBox(width: 8),
            Text(
              'Having trouble?',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────────────────────── DONE BUTTON ─────────────────────────

  Widget _buildDoneButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: OutlinedButton(
          onPressed: _handleClose,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white38, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text(
            'DONE',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── CUSTOM PAINTERS ─────────────────────────

class _CornerBracketPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final bool top;
  final bool left;

  _CornerBracketPainter({
    required this.color,
    required this.strokeWidth,
    required this.top,
    required this.left,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    if (top && left) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (top && !left) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (!top && left) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}