import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/storage/local_storage_manager.dart';

class UserProfileController extends GetxController {

  late UserModel? userModel;

  @override
  void onInit() {
    userModel = LocalStorageManager().getUser();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
