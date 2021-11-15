import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/storage/local_storage_manager.dart';
import 'package:collection/collection.dart';
import 'package:rentalz_gcs18830_flutter/app/routes/app_pages.dart';

class LoginController extends GetxController {
  /// email
  final email = ''.obs;
  final isEmailValid = false.obs;
  final emailInitialized = false.obs;
  final emailErrorText = ''.obs;
  TextEditingController emailController = TextEditingController();

  /// password
  final password = ''.obs;
  final isPasswordValid = false.obs;
  final passwordInitialized = false.obs;
  final passwordErrorText = ''.obs;
  final isShowPassword = false.obs;
  TextEditingController passwordController = TextEditingController();

  /// buttons
  final enableButton = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onEmailChanged(String email) {
    if (!emailInitialized.value) {
      emailInitialized.value = true;
    }
    if (email.isEmpty) {
      emailController.clear();
    }
    this.email.value = email;

    if (email.isEmpty) {
      emailErrorText.value = 'This field is required';
    }
    if (!GetUtils.isEmail(email)) {
      emailErrorText.value = 'This field is not email';
    }
    isEmailValid.value = email.isNotEmpty && GetUtils.isEmail(email);
    checkButtonValid();
  }

  void onPasswordChanged(String password) {
    if (!passwordInitialized.value) {
      passwordInitialized.value = true;
    }
    if (password.isEmpty) {
      passwordController.clear();
    }
    this.password.value = password;

    if (password.isEmpty) {
      passwordErrorText.value = 'This field is required';
    }
    if (password.length < 6) {
      passwordErrorText.value = 'This field must be at least 6 characters';
    }
    isPasswordValid.value = password.isNotEmpty && password.length > 6;
    checkButtonValid();
  }

  void checkButtonValid() {
    enableButton.value = isEmailValid.value && isPasswordValid.value;
  }

  void login() {
    if (enableButton.isTrue) {
      UserModel? user = LocalStorageManager().getUserList()?.userList?.firstWhereOrNull((user) {
        return user.email == email.value && user.password == password.value;
      });

      if (user != null) {
        LocalStorageManager().setUser(user);
        Get.offAndToNamed(Routes.LIST_HOME);
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(
              'Login Failed!',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  void onClose() {}
}
