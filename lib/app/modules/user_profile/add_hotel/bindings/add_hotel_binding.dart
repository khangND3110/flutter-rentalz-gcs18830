import 'package:get/get.dart';

import '../controllers/add_hotel_controller.dart';

class AddHotelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddHotelController>(
      () => AddHotelController(),
    );
  }
}
