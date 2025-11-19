import 'package:get/get.dart';

import '../controllers/report_summery_controller.dart';

class ReportSummeryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportSummeryController>(
      () => ReportSummeryController(),
    );
  }
}
