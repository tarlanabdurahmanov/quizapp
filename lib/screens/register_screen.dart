import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../constants/size.dart';
import '../constants/strings.dart';
import '../controllers/register_controller.dart';
import 'login_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_outline_button.dart';

class RegisterScreen extends StatelessWidget {
  final _registerController = Get.put(RegisterController());

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
                    "Hesab yaradın",
                    style: propmtTextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  sizedBoxHeight(height: 20),
                  _nameFormField(),
                  sizedBoxHeight(height: 20),
                  _usernameFormField(),
                  sizedBoxHeight(height: 20),
                  _emailFormField(),
                  sizedBoxHeight(height: 20),
                  _passwordFormField(),
                  sizedBoxHeight(height: 15),
                  Text(
                    "Şifrəni unutmusunuz?",
                    style: propmtTextStyle(
                        color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                  sizedBoxHeight(height: 15),
                  CustomButton(
                    text: "Qeydiyyat",
                    onPressed: () {
                      _registerController.register();
                    },
                    fontSize: 17,
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                  sizedBoxHeight(height: 15),
                  CustomOutlineButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(googleLogoPath, width: 25, height: 25),
                        Text(
                          "Google ilə qeydiyyat",
                          style: propmtTextStyle(
                            fontFamily: nunitoFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        sizedBoxWidth(width: 20),
                      ],
                    ),
                  ),
                  sizedBoxHeight(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Artıq bir hesabınız var mı?",
                        style: propmtTextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      sizedBoxWidth(width: 5),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(() => LoginScreen());
                        },
                        child: Text(
                          "Daxil ol",
                          style: propmtTextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _passwordFormField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Şifrə daxil edin';
        }
        return null;
      },
      onChanged: (value) {
        if (!value.isEmpty) {
          _registerController.isPasswordError.value = false;
          _registerController.isPasswordErrorText.value = "";
        } else {
          _registerController.isPasswordError.value = true;
        }
      },
      controller: _registerController.password,
      obscureText: !_registerController.showPassword.value,
      style: poppinsTextStyle(fontWeight: FontWeight.w600),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        errorText: _registerController.isPasswordErrorText.value == ""
            ? null
            : _registerController.isPasswordErrorText.value,
        filled: true,
        fillColor: fillColor,
        hintText: "Şifrə",
        contentPadding: EdgeInsets.all(0),
        hintStyle: propmtTextStyle(color: Color(0xFF9ba5b0)),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: _registerController.isPasswordError.value
                  ? Colors.red
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: _registerController.isPasswordError.value
                  ? Colors.red
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: _registerController.isPasswordError.value
                  ? Colors.red
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(FeatherIcons.lock, color: Color(0xFF9ba5b0)),
        suffixIcon: IconButton(
          splashRadius: 25,
          padding: EdgeInsets.only(right: 10, left: 0),
          icon: Icon(
              !_registerController.showPassword.value
                  ? FeatherIcons.eye
                  : FeatherIcons.eyeOff,
              color: Colors.black54),
          onPressed: () {
            _registerController.showPassword.value =
                !_registerController.showPassword.value;
          },
        ),
      ),
    );
  }

  TextFormField _usernameFormField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'İstifadəçi adı daxil edin';
        }
        return null;
      },
      onChanged: (value) {
        if (!value.isEmpty) {
          _registerController.isUsernameError.value = false;
          _registerController.isUsernameErrorText.value = "";
        } else {
          _registerController.isUsernameError.value = true;
        }
      },
      controller: _registerController.username,
      cursorColor: Colors.black,
      style: poppinsTextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        errorText: _registerController.isUsernameErrorText.value == ""
            ? null
            : _registerController.isUsernameErrorText.value,
        filled: true,
        fillColor: fillColor,
        hintText: "İstifadəçi adı",
        contentPadding: EdgeInsets.all(0),
        hintStyle: propmtTextStyle(color: Color(0xFF9ba5b0)),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: _registerController.isUsernameError.value
                  ? Colors.red
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: _registerController.isUsernameError.value
                  ? Colors.red
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: _registerController.isUsernameError.value
                  ? Colors.red
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(FeatherIcons.user, color: Color(0xFF9ba5b0)),
      ),
    );
  }

  TextFormField _nameFormField() {
    return TextFormField(
      controller: _registerController.name,
      cursorColor: Colors.black,
      style: poppinsTextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: "Ad soyad",
        contentPadding: EdgeInsets.all(0),
        hintStyle: propmtTextStyle(color: Color(0xFF9ba5b0)),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(FeatherIcons.user, color: Color(0xFF9ba5b0)),
      ),
    );
  }

  TextFormField _emailFormField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email daxil edin';
        }
        return null;
      },
      onChanged: (value) {
        if (!value.isEmpty) {
          _registerController.isEmailError.value = false;
          _registerController.isEmailErrorText.value = "";
        } else {
          _registerController.isEmailError.value = true;
        }
      },
      controller: _registerController.email,
      cursorColor: Colors.black,
      style: poppinsTextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        errorText: _registerController.isEmailErrorText.value == ""
            ? null
            : _registerController.isEmailErrorText.value,
        filled: true,
        fillColor: fillColor,
        hintText: "Email",
        contentPadding: EdgeInsets.all(0),
        hintStyle: propmtTextStyle(color: Color(0xFF9ba5b0)),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: _registerController.isEmailError.value
                  ? Colors.red
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: _registerController.isEmailError.value
                  ? Colors.red
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: _registerController.isEmailError.value
                  ? Colors.red
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(FeatherIcons.mail, color: Color(0xFF9ba5b0)),
      ),
    );
  }
}
