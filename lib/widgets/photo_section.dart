import 'package:flutter/material.dart';
import 'page_indicators.dart';

class PhotoSection extends StatelessWidget {
  final List<String> imagePaths;
  final int activePageIndex;
  final ValueChanged<int>? onPageIndicatorTap;

  const PhotoSection({
    super.key,
    required this.imagePaths,
    this.activePageIndex = 0,
    this.onPageIndicatorTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Crossfading images ──
            ...List.generate(imagePaths.length, (index) {
              return AnimatedOpacity(
                opacity: index == activePageIndex ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFD4E2C8),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 48,
                              color: Colors.black.withOpacity(0.15),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              imagePaths[index],
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.2),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),

            // ── Page indicators — top right inside photo ──
            Positioned(
              top: 16,
              right: 14,
              child: PageIndicators(
                itemCount: imagePaths.length,
                activeIndex: activePageIndex,
                onTap: onPageIndicatorTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}