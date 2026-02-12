import 'package:flutter/material.dart';
import 'loyalty_data.dart';
import 'loyalty_header.dart';

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
        bottom: 0,
      ),
      child: Center(
        child: LoyaltyHeader(
          resetDate: loyaltyData.resetDate,
        ),
      ),
    );
  }
}