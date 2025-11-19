import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/toast_service.dart';
import '../../SignUp/repositories/auth_repository.dart';

class ProfileController extends GetxController {
  final count = 0.obs;
  final AuthRepository _authRepository = AuthRepository();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  // 🚪 LOGOUT FUNCTION WITH ALERT DIALOG
  void showLogoutConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'logout_confirmation'.tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Get.theme.colorScheme.error,
          ),
        ),
        content: Text(
          'logout_message'.tr,
          style: TextStyle(
            color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          // Cancel Button
          TextButton(
            onPressed: () {
              Navigator.pop(Get.context!);
            },
            style: TextButton.styleFrom(
              foregroundColor: Get.theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            child: Text(
              'cancel'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Logout Button
          TextButton(
            onPressed: () {
              Navigator.pop(Get.context!);
              _performLogout();
            },
            style: TextButton.styleFrom(
              foregroundColor: Get.theme.colorScheme.error,
            ),
            child: Text(
              'logout'.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  // PERFORM ACTUAL LOGOUT
  Future<void> _performLogout() async {
    try {
      // Show loading indicator
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      // Perform logout
      await _authRepository.logout();

      // Show success message
      ApptoastUtils.showSuccess('logout_success'.tr);
    } catch (e) {
      ApptoastUtils.showError('logout_failed'.tr);
    } finally {
      if (Get.isDialogOpen == true) {
        Navigator.pop(Get.context!);
      }
    }
  }
}
