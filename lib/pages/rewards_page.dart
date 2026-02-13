import 'package:flutter/material.dart';

class RewardItem {
  final String name;
  final int price;
  final String imagePath;
  final String redeemCode;

  const RewardItem({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.redeemCode,
  });
}

class RewardsPage extends StatelessWidget {
  final VoidCallback? onClose;
  final int userPoints;

  const RewardsPage({
    super.key,
    this.onClose,
    required this.userPoints,
  });

  static const List<RewardItem> _rewards = [
    RewardItem(
      name: 'Espresso Shot',
      price: 300,
      imagePath: 'assets/images/reward1.png',
      redeemCode: 'ESP-7X2K-9M4A',
    ),
    RewardItem(
      name: 'Cappuccino',
      price: 500,
      imagePath: 'assets/images/reward2.png',
      redeemCode: 'CAP-3F8N-1B7Q',
    ),
    RewardItem(
      name: 'Caramel Latte',
      price: 800,
      imagePath: 'assets/images/reward3.png',
      redeemCode: 'LAT-5W1R-6D3J',
    ),
    RewardItem(
      name: 'Breakfast Combo',
      price: 1000,
      imagePath: 'assets/images/reward4.png',
      redeemCode: 'BRK-9T4E-2H8P',
    ),
    RewardItem(
      name: 'Premium Coffee Box',
      price: 3000,
      imagePath: 'assets/images/reward5.png',
      redeemCode: 'BOX-6L2Y-4C9V',
    ),
  ];

  void _handleClose(BuildContext context) {
    if (onClose != null) {
      onClose!();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _showRedeemDialog(BuildContext context, RewardItem reward) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (ctx) => _RedeemDialog(reward: reward),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF6EDE4),
            Color(0xFFE8D9C8),
            Color(0xFFD2B8A3),
          ],
        ),
      ),
      child: Column(
        children: [
          // ── Header ──
          Padding(
            padding: EdgeInsets.only(
              top: topPadding + 14,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => _handleClose(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.8),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.black87,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Rewards',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFE8A63A),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$userPoints',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Rewards list ──
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 6,
                bottom: bottomPadding + 20,
              ),
              itemCount: _rewards.length,
              itemBuilder: (context, index) {
                final reward = _rewards[index];
                final canAfford = userPoints >= reward.price;

                return _RewardCard(
                  reward: reward,
                  canAfford: canAfford,
                  onCollect: canAfford
                      ? () => _showRedeemDialog(context, reward)
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Reward Card ───────────────────────────────────────────────

class _RewardCard extends StatelessWidget {
  final RewardItem reward;
  final bool canAfford;
  final VoidCallback? onCollect;

  const _RewardCard({
    required this.reward,
    required this.canAfford,
    this.onCollect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.50),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.7),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.7),
              blurRadius: 1,
              spreadRadius: 0,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Image ──
            SizedBox(
              width: 120,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  reward.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8A63A).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.coffee_rounded,
                        size: 40,
                        color: Color(0xFFE8A63A),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ── Info + Button ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reward.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 15,
                          color: canAfford
                              ? const Color(0xFFE8A63A)
                              : Colors.black.withValues(alpha: 0.2),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${reward.price} pts',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: canAfford
                                ? Colors.black.withValues(alpha: 0.55)
                                : Colors.black.withValues(alpha: 0.25),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 36,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: canAfford ? 1.0 : 0.45,
                        child: ElevatedButton(
                          onPressed: onCollect,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: canAfford
                                ? Colors.black
                                : Colors.black.withValues(alpha: 0.3),
                            foregroundColor: Colors.white,
                            elevation: canAfford ? 3 : 0,
                            shadowColor: Colors.black.withValues(alpha: 0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            canAfford ? 'Collect' : 'Not enough pts',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Redeem Dialog (QR Code + Code) ────────────────────────────

class _RedeemDialog extends StatelessWidget {
  final RewardItem reward;

  const _RedeemDialog({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 36),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              reward.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Show this to the cashier',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(height: 24),

            // QR Code placeholder
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
              child: CustomPaint(
                painter: _FakeQRPainter(),
              ),
            ),
            const SizedBox(height: 20),

            // Code
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F0EB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                reward.redeemCode,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  letterSpacing: 1.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Close button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Fake QR Code Painter ──────────────────────────────────────

class _FakeQRPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final cellSize = size.width / 21;
    final margin = (size.width - cellSize * 21) / 2;

    // Deterministic "QR-like" pattern using a simple seed
    final List<List<bool>> grid = List.generate(
      21,
      (row) => List.generate(21, (col) {
        // Position detection patterns (3 corners)
        if (_isInFinderPattern(row, col, 0, 0)) return _finderValue(row, col, 0, 0);
        if (_isInFinderPattern(row, col, 0, 14)) return _finderValue(row, col, 0, 14);
        if (_isInFinderPattern(row, col, 14, 0)) return _finderValue(row, col, 14, 0);

        // Timing patterns
        if (row == 6) return col % 2 == 0;
        if (col == 6) return row % 2 == 0;

        // Data area — pseudo-random based on position
        final v = (row * 7 + col * 13 + row * col) % 5;
        return v < 2;
      }),
    );

    for (int row = 0; row < 21; row++) {
      for (int col = 0; col < 21; col++) {
        if (grid[row][col]) {
          canvas.drawRect(
            Rect.fromLTWH(
              margin + col * cellSize,
              margin + row * cellSize,
              cellSize,
              cellSize,
            ),
            paint,
          );
        }
      }
    }
  }

  bool _isInFinderPattern(int row, int col, int startRow, int startCol) {
    return row >= startRow &&
        row < startRow + 7 &&
        col >= startCol &&
        col < startCol + 7;
  }

  bool _finderValue(int row, int col, int startRow, int startCol) {
    final r = row - startRow;
    final c = col - startCol;
    // Outer border
    if (r == 0 || r == 6 || c == 0 || c == 6) return true;
    // White ring
    if (r == 1 || r == 5 || c == 1 || c == 5) return false;
    // Inner square
    return true;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}