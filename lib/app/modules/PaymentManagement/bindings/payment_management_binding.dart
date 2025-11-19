import 'package:get/get.dart';

import '../controllers/payment_management_controller.dart';

class PaymentManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentManagementController>(
      () => PaymentManagementController(),
    );
  }
}
