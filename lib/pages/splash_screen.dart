import 'package:flutter/material.dart';
import '../navigation/main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  bool _showMain = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      setState(() => _showMain = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _showMain
          ? const MainShell(key: ValueKey('main'))
          : Scaffold(
              key: const ValueKey('splash'),
              backgroundColor: Colors.transparent,
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFF6EDE4),
                      Color(0xFFE8D9C8),
                      Color(0xFFD2B8A3),
                    ],
                  ),
                ),
                child: Center(
                  child: FadeTransition(
                    opacity: _fadeIn,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 160,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text(
                          '☕',
                          style: TextStyle(fontSize: 80),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}