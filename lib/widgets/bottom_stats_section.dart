import 'package:flutter/material.dart';

/// Bottom 20% area: left = collect image button, gap for center card, right = stat text.
class BottomStatsSection extends StatelessWidget {
  final double cardHeight;
  final bool canCollect;
  final VoidCallback? onCollect;

  const BottomStatsSection({
    super.key,
    required this.cardHeight,
    required this.canCollect,
    this.onCollect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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

        // ── Gap for center card ──
        const Spacer(flex: 4),

        // ── Right — stat text ──
        Expanded(
          flex: 3,
          child: _SideStatCard(
            value: '3,910 m',
            label: 'mount bait fishing',
          ),
        ),
      ],
    );
  }
}

/// Collect button using pizza images.
/// pizza1.png (colored) when available, pizza0.png (white) when not.
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
        ? 'assets/images/coffee1.png'
        : 'assets/images/coffee0.png';

    return Container(
      child: GestureDetector(
        onTap: canCollect
            ? (onCollect ?? () {/* TODO: collect free pizza */})
            : null,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: canCollect ? 1.0 : 0.4,
          child: Padding(
            padding: const EdgeInsets.all(14),
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

/// Stat card that blends into the page background.
class _SideStatCard extends StatelessWidget {
  final String value;
  final String label;

  const _SideStatCard({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.black.withOpacity(0.25),
              fontSize: 7,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Center stat card — taller & wider, overflows upward over the photo section.
/// Positioned widget in the main page Stack.
class CenterStatCard extends StatelessWidget {
  final double totalHeight;

  const CenterStatCard({
    super.key,
    required this.totalHeight,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.38;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: cardWidth,
        height: totalHeight,
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '+4,423 m',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                ),
              ),

              const SizedBox(height: 8),

              // ── Animation placeholder ──
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.05),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.auto_graph_rounded,
                    size: 28,
                    color: Colors.black.withOpacity(0.12),
                  ),
                  // TODO: Replace with your animation widget
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'aluminium bait fishing',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.35),
                  fontSize: 7,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}