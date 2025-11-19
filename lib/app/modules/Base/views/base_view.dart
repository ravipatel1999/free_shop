import 'package:eccomerce_app/app/modules/ReportSummery/views/report_summery_view.dart';
import 'package:eccomerce_app/app/modules/shopping/views/shopping_view.dart';
import 'package:eccomerce_app/app/modules/SignUp/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: SafeArea(
        top: false,
        child: Obx(() {
          switch (baseController.currentIndex.value) {
            case 0:
              baseController.initializeDashbord();
              return const ShoppingView();
            case 1:
              baseController.initializeWishView();
              return const ReportSummeryView();

            case 2:
              baseController.initializeProfileView();
              return const ProfileView();
            default:
              return const SignUpView();
          }
        }),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: baseController.currentIndex.value,
          onTap: baseController.changeTabIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: AppColors.hintColor,
          unselectedFontSize: 10.sp,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.home,
                size: 18.sp,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.chart_2,
                size: 18.sp,
              ),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.user,
                size: 18.sp,
              ),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}
