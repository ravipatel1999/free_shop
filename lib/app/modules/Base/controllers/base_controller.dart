import 'package:eccomerce_app/app/modules/Dashbord/controllers/dashbord_controller.dart';
import 'package:eccomerce_app/app/modules/Wishlist/controllers/wishlist_controller.dart';
import 'package:eccomerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../../Profile/controllers/profile_controller.dart';
import '../../SignUp/repositories/auth_repository.dart';

class BaseController extends GetxController {
  final DashbordController dashbordController = Get.put(DashbordController());
  final WishlistController wishlistController = Get.put(WishlistController());
  final CartController cartController = Get.put(CartController());
  final ProfileController profileController = Get.put(ProfileController());
  final AuthRepository _authRepository = AuthRepository();

  final count = 0.obs;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthentication();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

  // 🔐 AUTHENTICATION CHECK
  void checkAuthentication() {
    if (!_authRepository.isUserLoggedIn()) {
      // User is not logged in, redirect to signup
      print("❌ User not authenticated, redirecting to SIGN_UP");
      Get.offAllNamed(Routes.SIGN_UP);
    }
  }

  void initializeDashbord() {
    dashbordController.onInit();
    print(' Dashbord');
  }

  void initializeWishView() {
    wishlistController.onInit();
    print('initialize Wishlist');
  }

  void initializeCartView() {
    cartController.onInit();
    print('Initializing CartView');
  }

  void initializeProfileView() {
    print('Initializing ProfileView');
    profileController.onInit();
  }

  void increment() => count.value++;
}
