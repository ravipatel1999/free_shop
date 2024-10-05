import 'package:get/get.dart';

import '../controllers/image_search_controller.dart';

class ImageSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageSearchController>(
      () => ImageSearchController(),
    );
  }
}
