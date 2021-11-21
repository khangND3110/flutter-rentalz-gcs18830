import 'dart:convert';

import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_list_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/storage/local_storage_manager.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/list_home/controllers/list_home_controller.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/report_list/controllers/report_list_controller.dart';

class HomeDetailController extends GetxController {
  final isLiked = false.obs;
  final houseModel = HotelModel().obs;

  final commentList = <String>[].obs;
  final comment = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final roomJson = jsonDecode(Get.parameters['house_model'] ?? '');
    houseModel.value = HotelModel.fromJson(roomJson);
    onInitComment();
  }

  void onInitComment() {
    commentList.value = houseModel.value.comments ?? [];
  }

  void onCommentChanged(String comment) {
    this.comment.value = comment;
  }

  void onSendComment() {
    if(comment.isNotEmpty) {
      HotelListModel? currentHotelList = LocalStorageManager().getHotelList();
      HotelModel currentHome = houseModel.value;

      commentList.add(comment.value);

      currentHome.comments = commentList.toList();

      int index = currentHotelList?.hotels?.indexWhere(
            (element) => element.name == houseModel.value.name,
      ) ??
          0;
      currentHotelList!.hotels![index] = currentHome;

      LocalStorageManager().setHotelList(currentHotelList);

      comment.value = '';

      ListHomeController _homeController = Get.put(ListHomeController());
      _homeController.onRefreshHomeList();

      ReportListController _reportController = Get.put(ReportListController());
      _reportController.onRefreshHomeList();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
