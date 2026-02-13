import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Templates',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MobileFrame(child: SplashScreen()),
    );
  }
}

class MobileFrame extends StatelessWidget {
  final Widget child;

  static const double _breakpoint = 550;
  static const double _widthRatio = 0.48;

  const MobileFrame({super.key, required this.child});

  /// Returns the constrained frame width for the current screen.
  /// Call this from anywhere that needs the same value (e.g. popups).
  static double frameWidth(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    if (screen.width <= _breakpoint) return screen.width;
    return screen.height * _widthRatio;
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    if (screen.width <= _breakpoint) {
      return child;
    }

    final width = screen.height * _widthRatio;
    final height = screen.height * 0.95;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Center(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 60,
                spreadRadius: 5,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: Size(width, height),
              padding: EdgeInsets.zero,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}