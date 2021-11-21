import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/storage/local_storage_manager.dart';

class ReportListController extends GetxController {
  final homeList = <HotelModel>[].obs;
  late UserModel? userModel;

  @override
  void onInit() {
    super.onInit();
    userModel = LocalStorageManager().getUser();
    onRefreshHomeList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onRefreshHomeList() {
    homeList.value = LocalStorageManager().getHotelList()?.hotels?.where((hotel) {
          return hotel.author?.email == userModel?.email;
        }).toList() ??
        [];
  }

  @override
  void onClose() {}
}
