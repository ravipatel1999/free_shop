import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../SignUp/repositories/auth_repository.dart';

class HomeController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();

  var userName = ''.obs;
  var userEmail = ''.obs;
  var userRole = ''.obs;
  var profileImage = ''.obs;
  @override
  void onInit() {
    _loadUserProfile();

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

  void _loadUserProfile() {
    final user = _authRepo.getUserDetails();

    userName.value = user['name'] ?? 'Guest User';
    userEmail.value = user['email'] ?? '';
    userRole.value = user['role'] ?? '';
    profileImage.value = user['profilePicture'] ?? '';
  }

  void onOrdersPressed() {
    Get.toNamed(Routes.ORDER_DETAILS);
  }

  void onShoppingPressed() {
    Get.toNamed(Routes.DASHBORD);
  }

  void onSettingsPressed() {}

  void onProfilePressed() {}

  void onEditProfilePressed() {}

  void onNotificationsPressed() {}

  void onViewAllActivityPressed() {}
}
