import 'package:flutter/material.dart';

class PageIndicators extends StatelessWidget {
  final int itemCount;
  final int activeIndex;
  final ValueChanged<int>? onTap;

  const PageIndicators({
    super.key,
    this.itemCount = 3,
    this.activeIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        final isActive = index == activeIndex;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: GestureDetector(
            onTap: () => onTap?.call(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isActive ? 46 : 34,
              height: isActive ? 46 : 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? Colors.white
                    : Colors.white.withOpacity(0.25),
                border: Border.all(
                  color: Colors.white.withOpacity(isActive ? 1 : 0.35),
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '0${index + 1}',
                style: TextStyle(
                  color: isActive ? Colors.black : Colors.white,
                  fontSize: isActive ? 14 : 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}