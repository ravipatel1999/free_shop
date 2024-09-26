import 'package:eccomerce_app/app/modules/Dashbord/controllers/dashbord_controller.dart';
import 'package:eccomerce_app/app/modules/Wishlist/controllers/wishlist_controller.dart';
import 'package:get/get.dart';
import '../../Cart/controllers/cart_controller.dart';
import '../../Profile/controllers/profile_controller.dart';

class BaseController extends GetxController {
  final DashbordController dashbordController = Get.put(DashbordController());
  final WishlistController wishlistController = Get.put(WishlistController());
  final CartController cartController = Get.put(CartController());
  final ProfileController profileController = Get.put(ProfileController());
  final count = 0.obs;
  var currentIndex = 0.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

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

  void initializeDashbord() {
    dashbordController.onInit();

    print('Initializing Dashbord');
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
