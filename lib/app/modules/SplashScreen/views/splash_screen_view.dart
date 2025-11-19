import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D47A1),
              Color(0xFF1565C0),
              Color(0xFF0C3CA3),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated Background Particles
            AnimatedBuilder(
              animation: controller.particleAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlePainter(
                      animation: controller.particleAnimation.value),
                  size: Size.infinite,
                );
              },
            ),

            // Animated Circles Background
            ScaleTransition(
              scale: controller.scaleAnimation,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 40,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),

            // Main Logo Container with Multiple Animations
            Center(
              child: ScaleTransition(
                scale: controller.scaleAnimation,
                child: RotationTransition(
                  turns: controller.rotateAnimation,
                  child: AnimatedBuilder(
                    animation: controller.pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: controller.pulseAnimation.value,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.8),
                                Colors.white.withOpacity(0.2),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.6),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                              BoxShadow(
                                color: const Color(0xFF0D47A1).withOpacity(0.3),
                                blurRadius: 60,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Logo Image
                              Image.asset(
                                'assets/Blue_Shield_with_Stylized__S_-removebg-preview.png',
                                width: 120,
                                height: 120,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Rotating Border Ring
            RotationTransition(
              turns: controller.rotateAnimation,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
              ),
            ),

            // Inner Rotating Ring
            RotationTransition(
              turns: Tween<double>(begin: 1.0, end: 0.0)
                  .animate(controller.rotateController),
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
