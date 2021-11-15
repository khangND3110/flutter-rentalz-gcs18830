import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_list_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/models/user/user_model.dart';
import 'package:rentalz_gcs18830_flutter/app/data/storage/local_storage_manager.dart';

class RegisterController extends GetxController {
  /// email
  final email = ''.obs;
  final isEmailValid = false.obs;
  final emailInitialized = false.obs;
  final emailErrorText = ''.obs;
  TextEditingController emailController = TextEditingController();

  /// full name
  final fullName = ''.obs;
  final isFullNameValid = false.obs;
  final fullNameInitialized = false.obs;
  final fullNameErrorText = ''.obs;
  TextEditingController fullNameController = TextEditingController();

  /// phone number
  final phoneNumber = ''.obs;
  final isPhoneNumberValid = false.obs;
  final phoneNumberInitialized = false.obs;
  final phoneNumberErrorText = ''.obs;
  TextEditingController phoneNumberController = TextEditingController();

  /// password
  final password = ''.obs;
  final isPasswordValid = false.obs;
  final passwordInitialized = false.obs;
  final passwordErrorText = ''.obs;
  final isShowPassword = false.obs;
  TextEditingController passwordController = TextEditingController();

  /// confirm password
  final confirmPassword = ''.obs;
  final isConfirmPasswordValid = false.obs;
  final confirmPasswordInitialized = false.obs;
  final confirmPasswordErrorText = ''.obs;
  final isShowConfirmPassword = false.obs;
  TextEditingController confirmPasswordController = TextEditingController();

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

  /// email
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

  /// full Name
  void onFullNameChanged(String fullName) {
    if (!fullNameInitialized.value) {
      fullNameInitialized.value = true;
    }
    if (fullName.isEmpty) {
      fullNameController.clear();
    }
    this.fullName.value = fullName;

    if (fullName.isEmpty) {
      fullNameErrorText.value = 'This field is required';
    }
    isFullNameValid.value = fullName.isNotEmpty;
    checkButtonValid();
  }

  /// phone number
  void onPhoneNumberChanged(String phoneNumber) {
    if (!phoneNumberInitialized.value) {
      phoneNumberInitialized.value = true;
    }
    if (phoneNumber.isEmpty) {
      phoneNumberController.clear();
    }
    this.phoneNumber.value = phoneNumber;

    if (phoneNumber.isEmpty) {
      phoneNumberErrorText.value = 'This field is required';
    }
    if (phoneNumber.length < 9) {
      phoneNumberErrorText.value = 'This field is not phone number';
    }
    isPhoneNumberValid.value = phoneNumber.isNotEmpty && phoneNumber.length > 9;
    checkButtonValid();
  }

  /// password
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

  /// confirm password
  void onConfirmPasswordChanged(String confirmPassword) {
    if (!confirmPasswordInitialized.value) {
      confirmPasswordInitialized.value = true;
    }
    if (confirmPassword.isEmpty) {
      confirmPasswordController.clear();
    }
    this.confirmPassword.value = confirmPassword;

    if (confirmPassword.isEmpty) {
      confirmPasswordErrorText.value = 'This field is required';
    }
    if (confirmPassword != password.value) {
      confirmPasswordErrorText.value = 'This field is not match with the password';
    }
    isConfirmPasswordValid.value = confirmPassword.isNotEmpty && confirmPassword == password.value;
    checkButtonValid();
  }

  void checkButtonValid() {
    enableButton.value = isEmailValid.value &&
        isFullNameValid.value &&
        isPhoneNumberValid.value &&
        isPasswordValid.value &&
        isConfirmPasswordValid.value;
  }

  void register() {
    if (enableButton.isTrue) {
      UserModel? currentUser =
          LocalStorageManager().getUserList()?.userList?.firstWhereOrNull((user) {
        return user.email == email.value;
      });

      if (currentUser == null) {
        UserListModel? userList = LocalStorageManager().getUserList();

        var user = UserModel(
          email: email.value,
          fullName: fullName.value,
          phoneNumber: phoneNumber.value,
          password: password.value,
        );

        if (userList == null) {
          UserListModel list = UserListModel();
          list.userList = [user];
          LocalStorageManager().setUserList(list);
        } else {
          userList.userList?.add(user);
          LocalStorageManager().setUserList(userList);
        }
        Get.back();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(
              'Register successfully',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(
              'Email already exists',
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
