import 'package:get/get.dart';

import '../controllers/privicy_policy_controller.dart';

class PrivicyPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivicyPolicyController>(
      () => PrivicyPolicyController(),
    );
  }
}
