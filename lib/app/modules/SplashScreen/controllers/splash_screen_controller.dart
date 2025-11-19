import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../SignUp/repositories/auth_repository.dart';

class SplashScreenController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController scaleController;
  late AnimationController rotateController;
  late AnimationController pulseController;
  late AnimationController particleController;

  late Animation<double> scaleAnimation;
  late Animation<double> rotateAnimation;
  late Animation<double> pulseAnimation;
  late Animation<double> particleAnimation;

  final AuthRepository _authRepository = AuthRepository();

  @override
  void onInit() {
    super.onInit();
    initializeAnimations();
    startAnimationSequence();
  }

  void initializeAnimations() {
    // Scale Animation - Bounce effect
    scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: scaleController, curve: Curves.elasticOut),
    );

    // Rotate Animation - Smooth rotation
    rotateController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    rotateAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: rotateController, curve: Curves.linear),
    );

    // Pulse Animation - Pulsing effect
    pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: pulseController, curve: Curves.easeInOut),
    );

    // Particle Animation
    particleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: particleController, curve: Curves.linear),
    );
  }

  void startAnimationSequence() {
    Future.delayed(const Duration(milliseconds: 300), () {
      scaleController.forward();
    });

    // Check authentication status after animations complete
    Future.delayed(const Duration(seconds: 3), () {
      checkAuthenticationStatus();
    });
  }

  void checkAuthenticationStatus() {
    final String token = _authRepository.getUserToken();

    if (token.isNotEmpty) {
      // User is logged in, navigate to base
      Get.offAllNamed(Routes.BASE);
    } else {
      // User is not logged in, navigate to signup
      Get.offAllNamed(Routes.SIGN_UP);
    }
  }

  @override
  void onClose() {
    scaleController.dispose();
    rotateController.dispose();
    pulseController.dispose();
    particleController.dispose();
    super.onClose();
  }
}

// PARTICLE PAINTER
class ParticlePainter extends CustomPainter {
  final double animation;

  ParticlePainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6 * (1 - animation))
      ..style = PaintingStyle.fill;

    // Draw animated particles
    for (int i = 0; i < 8; i++) {
      final angle = (i / 8) * 2 * 3.14159;
      final radius = 150 * animation;
      final dx = center.dx + radius * cos(angle);
      final dy = center.dy + radius * sin(angle);

      canvas.drawCircle(
        Offset(dx, dy),
        8 * (1 - animation),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) =>
      oldDelegate.animation != animation;
}
