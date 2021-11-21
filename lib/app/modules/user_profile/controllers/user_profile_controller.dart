import 'package:animations/animations.dart';
import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/storage/local_storage_manager.dart';
import 'package:rentalz_gcs18830_flutter/app/routes/app_pages.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_modal_configuration.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/dialog_widgets.dart';

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

  void onUserLogout() {
    showModal(
      context: Get.context!,
      configuration: BlurFadeScaleTransitionConfiguration(barrierDismissible: true),
      builder: (context) {
        return DialogWidgets().buildConfirmDialog(
          title: 'Log out',
          description: 'Are you sure to log out?',
          onNegativeClick: () {
            Get.back();
          },
          onPositiveClick: () {
            Get.offAndToNamed(Routes.LOGIN);
          },
        );
      },
    );
  }

  @override
  void onClose() {}
}
