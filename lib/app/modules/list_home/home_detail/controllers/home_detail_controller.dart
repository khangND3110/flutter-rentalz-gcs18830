import 'dart:convert';

import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_model.dart';

class HomeDetailController extends GetxController {
  final isLiked = false.obs;
  final houseModel = HotelModel().obs;

  @override
  void onInit() {
    super.onInit();
    final roomJson = jsonDecode(Get.parameters['house_model'] ?? '');
    houseModel.value = HotelModel.fromJson(roomJson);

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
