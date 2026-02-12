import 'package:flutter/material.dart';

class LoyaltyHeader extends StatelessWidget {
  final String logoPath;
  final DateTime resetDate;

  const LoyaltyHeader({
    super.key,
    this.logoPath = 'assets/images/logo.png',
    required this.resetDate,
  });

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final h = c.maxHeight;

        final logoHeight = h * 0.80;      // 👈 55% of header
        final titleFont = h * 0.09;       // "Resets"
        final dateFont = h * 0.13;        // date text

        return Row(
          children: [
            const Expanded(child: SizedBox()),

            // ── Logo (center) ──
            SizedBox(
              height: logoHeight,
              child: Image.asset(
                logoPath,
                fit: BoxFit.contain,
              ),
            ),

            // ── Date (right) ──
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Resets',
                        style: TextStyle(
                          fontSize: titleFont,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.35),
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                      Text(
                        _formatDate(resetDate),
                        style: TextStyle(
                          fontSize: dateFont,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
