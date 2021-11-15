import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_basic_text_input.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_button.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_password_text_input.dart';
import 'package:rentalz_gcs18830_flutter/gen/assets.gen.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  final Map<String, FocusNode> mapFocusNode = {
    "email": FocusNode(),
    "fullName": FocusNode(),
    "phoneNumber": FocusNode(),
    "password": FocusNode(),
    "confirmPassword": FocusNode(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset(Assets.json.starryBackground),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Container(
                width: Get.width,
                height: Get.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildEmailInput(),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: _buildFullNameInput(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: _buildPhoneNumberInput(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: _buildPasswordInput(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: _buildConfirmPasswordInput(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Obx(
                        () => CustomButton().buildEnableButton(
                          isButtonEnable: controller.enableButton.value,
                          title: 'Register',
                          onPresses: () {
                            controller.register();
                          },
                        ),
                      ),
                    ),
                    _buildLoginButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return Obx(
      () => CustomBasicTextInput(
        borderRadius: 25,
        inputTitle: 'Email',
        hintText: 'Your email',
        focusNode: mapFocusNode['email'],
        prefixIcon: Icon(
          FontAwesomeIcons.userAlt,
          size: 14,
          color: Colors.black,
        ),
        textEditingController: controller.emailController,
        onChanged: controller.onEmailChanged,
        isErrorVisible: !controller.isEmailValid.value,
        defaultValue: controller.email.value,
        initialized: controller.emailInitialized.value,
        onClearTextClicked: () => controller.onEmailChanged(''),
        errorText: controller.emailErrorText.value,
        onSubmitted: () {
          mapFocusNode['email']?.unfocus();
          FocusScope.of(Get.context!).requestFocus(mapFocusNode['fullName']);
        },
      ),
    );
  }

  Widget _buildFullNameInput() {
    return Obx(
      () => CustomBasicTextInput(
        borderRadius: 25,
        inputTitle: 'Full name',
        hintText: 'Your full name',
        focusNode: mapFocusNode['fullName'],
        prefixIcon: Icon(
          FontAwesomeIcons.userAlt,
          size: 14,
          color: Colors.black,
        ),
        textEditingController: controller.fullNameController,
        onChanged: controller.onFullNameChanged,
        isErrorVisible: !controller.isFullNameValid.value,
        defaultValue: controller.fullName.value,
        initialized: controller.fullNameInitialized.value,
        onClearTextClicked: () => controller.onFullNameChanged(''),
        errorText: controller.fullNameErrorText.value,
        onSubmitted: () {
          mapFocusNode['fullName']?.unfocus();
          FocusScope.of(Get.context!).requestFocus(mapFocusNode['phoneNumber']);
        },
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return Obx(
      () => CustomBasicTextInput(
        borderRadius: 25,
        inputTitle: 'Phone number',
        hintText: 'Your phone number',
        focusNode: mapFocusNode['phoneNumber'],
        prefixIcon: Icon(
          FontAwesomeIcons.userAlt,
          size: 14,
          color: Colors.black,
        ),
        textInputType: TextInputType.phone,
        textEditingController: controller.phoneNumberController,
        onChanged: controller.onPhoneNumberChanged,
        isErrorVisible: !controller.isPhoneNumberValid.value,
        defaultValue: controller.phoneNumber.value,
        initialized: controller.phoneNumberInitialized.value,
        onClearTextClicked: () => controller.onPhoneNumberChanged(''),
        errorText: controller.phoneNumberErrorText.value,
        onSubmitted: () {
          mapFocusNode['phoneNumber']?.unfocus();
          FocusScope.of(Get.context!).requestFocus(mapFocusNode['password']);
        },
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Obx(
      () => CustomPasswordTextInput(
        borderRadius: 25,
        inputTitle: 'Password',
        hintText: 'Your password',
        focusNode: mapFocusNode['password'],
        prefixIcon: Icon(
          FontAwesomeIcons.lock,
          size: 14,
          color: Colors.black,
        ),
        textEditingController: controller.passwordController,
        onChanged: controller.onPasswordChanged,
        isErrorVisible: !controller.isPasswordValid.value,
        defaultValue: controller.password.value,
        initialized: controller.passwordInitialized.value,
        onShowPasswordClicked: () {
          controller.isShowPassword.value = !controller.isShowPassword.value;
        },
        isShowPassword: controller.isShowPassword.value,
        errorText: controller.passwordErrorText.value,
        onSubmitted: () {
          mapFocusNode['password']?.unfocus();
          FocusScope.of(Get.context!).requestFocus(mapFocusNode['confirmPassword']);
        },
      ),
    );
  }

  Widget _buildConfirmPasswordInput() {
    return Obx(
      () => CustomPasswordTextInput(
        borderRadius: 25,
        inputTitle: 'Confirm password',
        hintText: 'Confirm your password',
        focusNode: mapFocusNode['confirmPassword'],
        prefixIcon: Icon(
          FontAwesomeIcons.lock,
          size: 14,
          color: Colors.black,
        ),
        textEditingController: controller.confirmPasswordController,
        onChanged: controller.onConfirmPasswordChanged,
        isErrorVisible: !controller.isConfirmPasswordValid.value,
        defaultValue: controller.confirmPassword.value,
        initialized: controller.confirmPasswordInitialized.value,
        onShowPasswordClicked: () {
          controller.isShowConfirmPassword.value = !controller.isShowConfirmPassword.value;
        },
        isShowPassword: controller.isShowConfirmPassword.value,
        errorText: controller.confirmPasswordErrorText.value,
        onSubmitted: () {
          mapFocusNode['confirmPassword']?.unfocus();
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      height: 30,
      width: 100,
      margin: EdgeInsets.only(top: 20),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
