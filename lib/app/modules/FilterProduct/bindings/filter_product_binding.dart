import 'package:get/get.dart';

import '../controllers/filter_product_controller.dart';

class FilterProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Filtercontroller>(
      () => Filtercontroller(),
    );
  }
}
