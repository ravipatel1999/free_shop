import 'package:eccomerce_app/app/modules/Cart/views/cart_view.dart';
import 'package:eccomerce_app/app/modules/Dashbord/views/dashbord_view.dart';
import 'package:eccomerce_app/app/modules/SignUp/views/sign_up_view.dart';
import 'package:eccomerce_app/app/modules/Wishlist/views/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../components/TextField/constant/app_color.dart';
import '../../Profile/views/profile_view.dart';
import '../controllers/base_controller.dart';

class BaseView extends GetView<BaseController> {
  BaseView({super.key});
  final BaseController baseController = Get.put(BaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (baseController.currentIndex.value) {
          case 0:
            baseController.initializeDashbord();
            return const DashbordView();
          case 1:
            baseController.initializeWishView();
            return const WishlistView();
          case 2:
            baseController.initializeCartView();
            return const CartView();
          case 3:
            baseController.initializeProfileView();
            return const ProfileView();
          default:
            return const SignUpView();
        }
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: baseController.currentIndex.value,
          onTap: baseController.changeTabIndex,
          selectedItemColor: AppColors.blackColor,
          unselectedItemColor: AppColors.hintColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          items: const [
            BottomNavigationBarItem(
              backgroundColor: AppColors.greenColor,
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.heart),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.user),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}
