import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/api_exceptions.dart';
import '../../../core/utils/logger.dart';
import '../../../routes/app_pages.dart';
import '../../../services/toast_service.dart';
import '../repositories/auth_repository.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController(text: 'newuser65@example.com');
  final passwordController = TextEditingController(text: '1234');
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;
  final isLoading = false.obs;
  final isTermsAccepted = false.obs;
  final AuthRepository _authRepo = AuthRepository();

  @override
  void onInit() {
    super.onInit();
    _authRepo.initializeDeviceId();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkExistingSession();
    });
  }

  void checkExistingSession() {
    if (_authRepo.isUserLoggedIn()) {
      Get.offAllNamed(Routes.BASE);
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ApptoastUtils.showError("Please enter both email and password");
      return;
    }

    isLoading.value = true;
    try {
      await _authRepo.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      final user = _authRepo.getUserDetails();
      AppLogger.info("Login completed successfully for: ${user['name']}");
    } catch (e) {
      if (!_isAnotherDeviceError(e)) {
        ApptoastUtils.showError("Invalid email or password");
      }
    } finally {
      isLoading.value = false;
    }
  }

  bool _isAnotherDeviceError(dynamic e) {
    return e is ApiException &&
        e.message.toLowerCase().contains('another device');
  }

  void forgotPassword() {}
  void showPrivacyPolicy() {}
  void showTermsOfService() {}

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
