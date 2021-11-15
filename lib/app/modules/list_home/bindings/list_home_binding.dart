import 'package:get/get.dart';

import '../controllers/list_home_controller.dart';

class ListHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListHomeController>(
      () => ListHomeController(),
    );
  }
}
