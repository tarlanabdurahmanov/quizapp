import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../constants/size.dart';
import '../constants/strings.dart';
import '../controllers/login_controller.dart';
import 'register_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_outline_button.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  final _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(logoPath),
                  Text(
                    "Hesabınıza daxil olun",
                    style: propmtTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  sizedBoxHeight(height: 20),
                  CustomTextFormField(
                    hintText: "Email və ya istifadəçi adı",
                    errorText: _loginController.isUsernameErrorText.value == ""
                        ? null
                        : _loginController.isUsernameErrorText.value,
                    fillColor: fillColor,
                    borderColor: _loginController.isUsernameError.value
                        ? Colors.red
                        : Colors.transparent,
                    prefixIcon: FeatherIcons.user,
                    controller: _loginController.username,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email və ya istifadəçi adı daxil edin';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (!value.isEmpty) {
                        _loginController.isUsernameError.value = false;
                        _loginController.isUsernameErrorText.value = "";
                      } else {
                        _loginController.isUsernameError.value = true;
                      }
                    },
                  ),
                  sizedBoxHeight(height: 20),
                  CustomTextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Şifrə daxil edin';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (!value.isEmpty) {
                        _loginController.isPasswordError.value = false;
                        _loginController.isPasswordErrorText.value = "";
                      } else {
                        _loginController.isPasswordError.value = true;
                      }
                    },
                    controller: _loginController.password,
                    obscureText: !_loginController.showPassword.value,
                    borderColor: _loginController.isPasswordError.value
                        ? Colors.red
                        : Colors.transparent,
                    suffixIcon: IconButton(
                      splashRadius: 25,
                      padding: EdgeInsets.only(right: 10, left: 0),
                      icon: Icon(
                          !_loginController.showPassword.value
                              ? FeatherIcons.eye
                              : FeatherIcons.eyeOff,
                          color: Colors.black54),
                      onPressed: () {
                        _loginController.showPassword.value =
                            !_loginController.showPassword.value;
                      },
                    ),
                    fillColor: fillColor,
                    hintText: "Şifrə",
                    prefixIcon: FeatherIcons.lock,
                    errorText: _loginController.isPasswordErrorText.value == ""
                        ? null
                        : _loginController.isPasswordErrorText.value,
                  ),
                  sizedBoxHeight(height: 15),
                  Text(
                    "Şifrəni unutmusunuz?",
                    style: propmtTextStyle(
                        color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                  sizedBoxHeight(height: 15),
                  _loginBtn(),
                  sizedBoxHeight(height: 15),
                  _googleLoginBtn(),
                  sizedBoxHeight(height: 30),
                  _bottomText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomButton _loginBtn() {
    return CustomButton(
      text: "Daxil ol",
      onPressed: () {
        _loginController.login();
      },
      fontSize: 17,
      color: primaryColor,
      textColor: Colors.white,
    );
  }

  CustomOutlineButton _googleLoginBtn() {
    return CustomOutlineButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(googleLogoPath, width: 25, height: 25),
          Text(
            "Google ilə daxil olun",
            style: propmtTextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          sizedBoxWidth(width: 20),
        ],
      ),
    );
  }

  Row _bottomText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Hesabınız yoxdur ?",
          style: propmtTextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        sizedBoxWidth(width: 5),
        GestureDetector(
          onTap: () {
            Get.delete<LoginController>();
            Get.offAll(() => RegisterScreen());
          },
          child: Text(
            "Qeydiyyat",
            style: propmtTextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }



}
