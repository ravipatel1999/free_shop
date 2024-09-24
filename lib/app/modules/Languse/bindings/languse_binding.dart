import 'package:get/get.dart';

import '../controllers/languse_controller.dart';

class LanguseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguseController>(
      () => LanguseController(),
    );
  }
}
