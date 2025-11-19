import 'package:get/get.dart';

import '../modules/Base/bindings/base_binding.dart';
import '../modules/Base/views/base_view.dart';
import '../modules/Cart/bindings/cart_binding.dart';
import '../modules/Cart/views/cart_view.dart';
import '../modules/Contact/bindings/contact_binding.dart';
import '../modules/Contact/views/contact_view.dart';
import '../modules/Customer/bindings/customer_binding.dart';
import '../modules/Customer/views/customer_view.dart';
import '../modules/Dashbord/bindings/dashbord_binding.dart';
import '../modules/Dashbord/views/dashbord_view.dart';
import '../modules/FilterProduct/bindings/filter_product_binding.dart';
import '../modules/FilterProduct/views/filter_product_view.dart';
import '../modules/Image_Search/bindings/image_search_binding.dart';
import '../modules/Image_Search/views/image_search_view.dart';
import '../modules/Languse/bindings/languse_binding.dart';
import '../modules/Languse/views/languse_view.dart';
import '../modules/OnBording/bindings/on_bording_binding.dart';
import '../modules/OnBording/views/on_bording_view.dart';
import '../modules/OrderDetails/bindings/order_details_binding.dart';
import '../modules/OrderDetails/views/order_details_view.dart';
import '../modules/PaymentManagement/bindings/payment_management_binding.dart';
import '../modules/PaymentManagement/views/payment_management_view.dart';
import '../modules/PrivicyPolicy/bindings/privicy_policy_binding.dart';
import '../modules/PrivicyPolicy/views/privicy_policy_view.dart';
import '../modules/ProductDetails/bindings/product_details_binding.dart';
import '../modules/ProductDetails/views/product_details_view.dart';
import '../modules/Profile/bindings/profile_binding.dart';
import '../modules/Profile/views/profile_view.dart';
import '../modules/Rating_Review/bindings/rating_review_binding.dart';
import '../modules/Rating_Review/views/rating_review_view.dart';
import '../modules/ReportSummery/bindings/report_summery_binding.dart';
import '../modules/ReportSummery/views/report_summery_view.dart';
import '../modules/Search_Product/bindings/search_product_binding.dart';
import '../modules/Search_Product/views/search_product_view.dart';
import '../modules/Short_filter/bindings/short_filter_binding.dart';
import '../modules/Short_filter/views/short_filter_view.dart';
import '../modules/SignUp/bindings/sign_up_binding.dart';
import '../modules/SignUp/views/sign_up_view.dart';
import '../modules/SplashScreen/bindings/splash_screen_binding.dart';
import '../modules/SplashScreen/views/splash_screen_view.dart';
import '../modules/Wishlist/bindings/wishlist_binding.dart';
import '../modules/Wishlist/views/wishlist_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/shopping/bindings/shopping_binding.dart';
import '../modules/shopping/views/shopping_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH_SCREEN;

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
    GetPage(
      name: _Paths.BASE,
      page: () => BaseView(),
      binding: BaseBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PRODUCT,
      page: () => const SearchProductView(),
      binding: SearchProductBinding(),
    ),
    GetPage(
      name: _Paths.FILTER_PRODUCT,
      page: () => const FilterProductView(),
      binding: FilterProductBinding(),
    ),
    GetPage(
      name: _Paths.SHORT_FILTER,
      page: () => ShortFilterView(),
      binding: ShortFilterBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_SEARCH,
      page: () => const ImageSearchView(),
      binding: ImageSearchBinding(),
    ),
    GetPage(
      name: _Paths.RATING_REVIEW,
      page: () => const RatingReviewView(),
      binding: RatingReviewBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SHOPPING,
      page: () => const ShoppingView(),
      binding: ShoppingBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT,
      page: () => const ContactView(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER,
      page: () => const CustomerView(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_MANAGEMENT,
      page: () => const PaymentManagementView(),
      binding: PaymentManagementBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_SUMMERY,
      page: () => const ReportSummeryView(),
      binding: ReportSummeryBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => const ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PRIVICY_POLICY,
      page: () => const PrivicyPolicyView(),
      binding: PrivicyPolicyBinding(),
    ),
  ];
}
