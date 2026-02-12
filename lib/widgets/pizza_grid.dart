import 'dart:math' as math;
import 'package:flutter/material.dart';

class PizzaGrid extends StatelessWidget {
  final int pizzasBought;
  final int total;
  final String activePizzaPath;
  final String inactivePizzaPath;

  const PizzaGrid({
    super.key,
    required this.pizzasBought,
    this.total = 10,
    this.activePizzaPath = 'assets/images/coffee1.png',
    this.inactivePizzaPath = 'assets/images/coffee0.png',
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final h = c.maxHeight;
        final w = c.maxWidth;

        final rowH = h * 0.40; // 40% + 40%
        final gapV = h * 0.1; // 20% between rows

        // Each row has 5 pizzas. Make sure pizzas fit horizontally and vertically.
        // Horizontal max per tile = w / 5 (spaceEvenly adds spacing too, so be a bit conservative).
        final tileSize = math.min(rowH, w / 5.4);

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: rowH,
              child: _buildRow(start: 0, count: 5, tileSize: tileSize),
            ),
            SizedBox(height: gapV),
            SizedBox(
              height: rowH,
              child: _buildRow(start: 5, count: 5, tileSize: tileSize),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow({
    required int start,
    required int count,
    required double tileSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(count, (i) {
        final index = start + i;
        final isBought = index < pizzasBought;

        return SizedBox(
          width: tileSize,
          height: tileSize,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isBought ? 1.0 : 0.45,
            child: Image.asset(
              isBought ? activePizzaPath : inactivePizzaPath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: isBought
                        ? const Color(0xFFE8A63A).withOpacity(0.2)
                        : Colors.black.withOpacity(0.04),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.local_pizza,
                    size: tileSize * 0.45,
                    color: isBought
                        ? const Color(0xFFE8A63A)
                        : Colors.black.withOpacity(0.15),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
