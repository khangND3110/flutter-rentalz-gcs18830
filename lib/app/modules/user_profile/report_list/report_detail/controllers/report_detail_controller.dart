import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_list_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/hotel/hotel_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/storage/local_storage_manager.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/list_home/controllers/list_home_controller.dart';
import 'package:rentalz_gcs18830_flutter/app/modules/user_profile/report_list/controllers/report_list_controller.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_modal_configuration.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/dialog_widgets.dart';

class ReportDetailController extends GetxController {
  final houseModel = HotelModel().obs;

  @override
  void onInit() {
    super.onInit();
    final houseJson = jsonDecode(Get.parameters['house_model'] ?? '');
    houseModel.value = HotelModel.fromJson(houseJson);
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onDeleteClick() {
    showModal(
      context: Get.context!,
      configuration: BlurFadeScaleTransitionConfiguration(barrierDismissible: true),
      builder: (context) {
        return DialogWidgets().buildConfirmDialog(
          title: 'Remove hotel',
          description: 'Are you sure to remove this hotel?',
          onNegativeClick: () {
            Get.back();
          },
          onPositiveClick: () {
            onDeleteHome();
            Get.back();
          },
        );
      },
    );
  }

  void onDeleteHome() {
    HotelListModel? currentHotelList = LocalStorageManager().getHotelList();

    int? index = currentHotelList?.hotels?.indexWhere((element) => element.name == houseModel.value.name);
    currentHotelList?.hotels?.removeAt(index ?? -1);
    LocalStorageManager().setHotelList(currentHotelList);

    ListHomeController _listHomeController = Get.put(ListHomeController());
    _listHomeController.onRefreshHomeList();
    ReportListController _reportListController = Get.put(ReportListController());
    _reportListController.onRefreshHomeList();

    Get.back();

  }

  @override
  void onClose() {}
}
