import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/home');
      }
    });
    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();
    super.initState();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/lottie/splash_screen/Gravity.json',
        repeat: true,
        frameRate: FrameRate(120),
        controller: _animationController,
        height: 100,
        width: 100,
      ),
    );;
  }
}
