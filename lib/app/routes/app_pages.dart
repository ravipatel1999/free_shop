import 'package:get/get.dart';

import '../modules/Dashbord/bindings/dashbord_binding.dart';
import '../modules/Dashbord/views/dashbord_view.dart';
import '../modules/Languse/bindings/languse_binding.dart';
import '../modules/Languse/views/languse_view.dart';
import '../modules/OnBording/bindings/on_bording_binding.dart';
import '../modules/OnBording/views/on_bording_view.dart';
import '../modules/SignUp/bindings/sign_up_binding.dart';
import '../modules/SignUp/views/sign_up_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ON_BORDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ON_BORDING,
      page: () => const OnBordingView(),
      binding: OnBordingBinding(),
    ),
    GetPage(
      name: _Paths.LANGUSE,
      page: () => const LanguseView(),
      binding: LanguseBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.DASHBORD,
      page: () => const DashbordView(),
      binding: DashbordBinding(),
    ),
  ];
}
