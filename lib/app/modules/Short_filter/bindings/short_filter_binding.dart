import 'package:get/get.dart';

import '../controllers/short_filter_controller.dart';

class ShortFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShortFilterController>(
      () => ShortFilterController(),
    );
  }
}
