import 'package:get/get.dart';

import '../controllers/report_edit_controller.dart';

class ReportEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportEditController>(
      () => ReportEditController(),
    );
  }
}
