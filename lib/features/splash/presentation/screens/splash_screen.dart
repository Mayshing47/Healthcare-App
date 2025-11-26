import 'package:flutter/material.dart';
import 'package:health_care_application/main.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        navigatorKey.currentState!.pushReplacementNamed('/authGate');
      }
    });

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    //Dispose the controller when it's no longer needed.
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLottieImage(),
          const SizedBox(height: 40),
          Text(
            'Family Doctor',
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _buildLottieImage() {
    return Lottie.asset(
        controller: _animationController,
        'assets/images/splash_dark_image.json', height: 300);
  }
}
