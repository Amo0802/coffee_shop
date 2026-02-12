import 'package:flutter/material.dart';
import 'loyalty_data.dart';
import 'loyalty_header.dart';
import 'pizza_grid.dart';

class TopSection extends StatelessWidget {
  final double topPadding;
  final LoyaltyData loyaltyData;

  const TopSection({
    super.key,
    this.topPadding = 0,
    required this.loyaltyData,
  });

  @override
Widget build(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.only(
      top: topPadding + 8,
      left: 22,
      right: 22,
      bottom: 10,
    ),
    child: Column(
      children: [
        // 50%
        Expanded(
          flex: 1,
          child: Center(
            child: LoyaltyHeader(
              resetDate: loyaltyData.resetDate,
            ),
          ),
        ),

        // 50%
        Expanded(
          flex: 1,
          child: PizzaGrid(
            pizzasBought: loyaltyData.pizzasBought,
            total: loyaltyData.totalRequired,
          ),
        ),
      ],
    ),
  );
}
}