import 'package:flutter/material.dart';

/// Bottom area: left = collect image button, center = points card, right = rewards button.
class BottomStatsSection extends StatelessWidget {
  final double cardHeight;
  final bool canCollect;
  final int points;
  final VoidCallback? onCollect;
  final VoidCallback? onRewards;

  const BottomStatsSection({
    super.key,
    required this.cardHeight,
    required this.canCollect,
    required this.points,
    this.onCollect,
    this.onRewards,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Left — collect image button ──
          Expanded(
            flex: 3,
            child: _CollectImageButton(
              canCollect: canCollect,
              onCollect: onCollect,
            ),
          ),

          const SizedBox(width: 10),

          // ── Center — points card (stands out) ──
          Expanded(
            flex: 4,
            child: _CenterPointsCard(points: points),
          ),

          const SizedBox(width: 10),

          // ── Right — rewards button ──
          Expanded(
            flex: 3,
            child: _RewardsButton(onTap: onRewards),
          ),
        ],
      ),
    );
  }
}

/// Collect button with a frosted container background.
class _CollectImageButton extends StatelessWidget {
  final bool canCollect;
  final VoidCallback? onCollect;

  const _CollectImageButton({
    required this.canCollect,
    this.onCollect,
  });

  @override
  Widget build(BuildContext context) {
    final imagePath = canCollect
        ? 'assets/images/freeCoffee1.png'
        : 'assets/images/freeCoffee0.png';

    return GestureDetector(
      onTap: canCollect ? (onCollect ?? () {}) : null,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.45),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.6),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              blurRadius: 1,
              spreadRadius: 0,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: canCollect ? 1.0 : 0.4,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.local_pizza,
                  size: 36,
                  color: canCollect
                      ? const Color(0xFFE8A63A)
                      : Colors.black.withOpacity(0.15),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Center card — shows user points, visually prominent with deeper shadow.
class _CenterPointsCard extends StatelessWidget {
  final int points;

  const _CenterPointsCard({required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.9),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$points',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 1),
            Text(
              'pts',
              style: TextStyle(
                color: Colors.black.withOpacity(0.35),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Rewards button styled to match the app aesthetic with shadow.
class _RewardsButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _RewardsButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.20),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.card_giftcard_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 22,
              ),
              const SizedBox(height: 4),
              const Text(
                'Rewards',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}