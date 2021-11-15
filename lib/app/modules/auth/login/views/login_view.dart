import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rentalz_gcs18830_flutter/app/routes/app_pages.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_basic_text_input.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_button.dart';
import 'package:rentalz_gcs18830_flutter/app/widgets/custom_password_text_input.dart';
import 'package:rentalz_gcs18830_flutter/gen/assets.gen.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final Map<String, FocusNode> mapFocusNode = {
    "email": FocusNode(),
    "password": FocusNode(),
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
                width:Get.width,
                height:Get.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildGreeting(),
                    _buildEmailInput(),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: _buildPasswordInput(),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Obx(
                        () => CustomButton().buildEnableButton(
                          isButtonEnable: controller.enableButton.value,
                          title: 'Login',
                          onPresses: () {
                            controller.login();
                          },
                        ),
                      ),
                    ),
                    _buildRegisterButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Text(
        'Welcome to RentalZ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 50,
        ),
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
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      height: 30,
      width: 100,
      margin: EdgeInsets.only(top: 20),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.REGISTER);
          },
          child: Center(
            child: Text(
              'Register',
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
