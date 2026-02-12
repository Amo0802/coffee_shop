import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/top_section.dart';
import '../widgets/photo_section.dart';
import '../widgets/bottom_stats_section.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/loyalty_data.dart';

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
  int _activeNavIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF6EDE4), // soft cream
              Color(0xFFE8D9C8), // latte
              Color(0xFFD2B8A3), // calm light brown
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final screenH = constraints.maxHeight;

                  final topH = screenH * 0.30;
                  final midH = screenH * 0.50;
                  final botH = screenH * 0.20;
                  final overflow = botH * 0.35;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: topH,
                            width: double.infinity,
                            child: TopSection(
                              topPadding: topPadding,
                              loyaltyData: _loyaltyData,
                            ),
                          ),
                          SizedBox(
                            height: midH,
                            width: double.infinity,
                            child: PhotoSection(
                              imagePaths: _images,
                              activePageIndex: _activePageIndex,
                              onPageIndicatorTap: _onPageSelected,
                            ),
                          ),
                          SizedBox(
                            height: botH,
                            width: double.infinity,
                            child: BottomStatsSection(
                              cardHeight: botH,
                              canCollect: _loyaltyData.canCollect,
                              onCollect: () {
                                // TODO: Call backend to collect reward
                              },
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: CenterStatCard(
                          totalHeight: botH + overflow,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            BottomNavBar(
              currentIndex: _activeNavIndex,
              onTap: (index) {
                setState(() => _activeNavIndex = index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
