import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import '../widgets/top_section.dart';
import '../widgets/photo_section.dart';
import '../widgets/pizza_grid.dart';
import '../widgets/bottom_stats_section.dart';
import '../widgets/loyalty_data.dart';
import 'rewards_page.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  static const List<String> _images = [
    'assets/images/cf1.png',
    'assets/images/cf2.png',
    'assets/images/cf3.png',
  ];

  int _activePageIndex = 0;
  late Timer _autoRotateTimer;

  final LoyaltyData _loyaltyData = LoyaltyData.dummy();

  @override
  void initState() {
    super.initState();
    _startAutoRotate();
  }

  @override
  void dispose() {
    _autoRotateTimer.cancel();
    super.dispose();
  }

  void _startAutoRotate() {
    _autoRotateTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        if (!mounted) return;
        setState(() {
          _activePageIndex = (_activePageIndex + 1) % _images.length;
        });
      },
    );
  }

  void _onPageSelected(int index) {
    setState(() => _activePageIndex = index);
    _autoRotateTimer.cancel();
    _startAutoRotate();
  }

  void _openRewards() {
    final width = MobileFrame.frameWidth(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(maxWidth: width),
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(ctx).size.height,
        child: RewardsPage(
          userPoints: _loyaltyData.points,
          onClose: () => Navigator.of(ctx).pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    final topPadding = MediaQuery.of(context).padding.top;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenH = constraints.maxHeight;

        final topH = screenH * 0.17;
        final midH = screenH * 0.50;
        final gridH = screenH * 0.18;
        final botH = screenH * 0.15;

        return Column(
          children: [
            // ── Header ──
            SizedBox(
              height: topH,
              width: double.infinity,
              child: TopSection(
                topPadding: topPadding,
                loyaltyData: _loyaltyData,
              ),
            ),

            // ── Photo section ──
            SizedBox(
              height: midH,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: PhotoSection(
                  imagePaths: _images,
                  activePageIndex: _activePageIndex,
                  onPageIndicatorTap: _onPageSelected,
                ),
              ),
            ),

            // ── Pizza grid ──
            SizedBox(
              height: gridH,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.45),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.6),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.7),
                        blurRadius: 1,
                        spreadRadius: 0,
                        offset: const Offset(0, -1),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: PizzaGrid(
                    pizzasBought: _loyaltyData.pizzasBought,
                    total: _loyaltyData.totalRequired,
                  ),
                ),
              ),
            ),

            // ── Bottom stats ──
            SizedBox(
              height: botH,
              width: double.infinity,
              child: BottomStatsSection(
                cardHeight: botH,
                canCollect: _loyaltyData.canCollect,
                points: _loyaltyData.points,
                onCollect: () {
                  // TODO: Call backend to collect reward
                },
                onRewards: _openRewards,
              ),
            ),
          ],
        );
      },
    );
  }
}