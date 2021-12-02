import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quizapp/constants/colors.dart';
import 'package:quizapp/constants/fonts.dart';
import 'package:quizapp/constants/size.dart';
import 'package:quizapp/constants/strings.dart';
import 'package:quizapp/controllers/profile_controller.dart';
import 'package:quizapp/widgets/custom_button.dart';
import 'package:quizapp/widgets/custom_text_form_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:avatar_view/avatar_view.dart';

class ProfileScreen extends StatelessWidget {
  final _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Text(
          "Profile Edit",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          _backgroundGradient(),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // double width = constraints.maxWidth;
                  // double height = constraints.maxHeight;
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      child: Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Obx(
                              () => Center(
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    _profileController.isImage.value
                                        ? CircleAvatar(
                                            radius: 40,
                                            backgroundImage: FileImage(File(
                                                _profileController
                                                    .imagePath.value)),
                                          )
                                        : SizedBox(),
                                    !_profileController.isImage.value
                                        ? Obx(
                                            () => AvatarView(
                                              radius: 40,
                                              borderWidth: 1,
                                              borderColor: context
                                                  .theme.colorScheme.background
                                                  .withOpacity(0.1),
                                              avatarType: AvatarType.CIRCLE,
                                              backgroundColor: Colors.red,
                                              imagePath: _profileController
                                                          .profileImage.value !=
                                                      ""
                                                  ? "${_profileController.profileImage.value}"
                                                  : userDefaultPath,
                                              placeHolder:
                                                  Image.asset(userDefaultPath),
                                              errorWidget: Container(
                                                child: Icon(
                                                  Icons.error,
                                                  size: 20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    GestureDetector(
                                      onTap: () {
                                        _profileController.getImage();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade200,
                                              blurRadius: 2,
                                              offset: Offset(0, 1),
                                              spreadRadius: 2,
                                            )
                                          ],
                                        ),
                                        child: Icon(FeatherIcons.camera,
                                            color: Colors.black, size: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            sizedBoxHeight(height: 30),
                            CustomTextFormField(
                              hintText: "Ad soyad",
                              fillColor: fillColor,
                              borderColor: Colors.transparent,
                              controller: _profileController.name,
                              prefixIcon: FeatherIcons.user,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ad daxil edin';
                                }
                                return null;
                              },
                            ),
                            sizedBoxHeight(height: 20),
                            CustomTextFormField(
                              hintText: "İstifadəçi adı",
                              fillColor: fillColor,
                              borderColor:
                                  _profileController.isUsernameError.value
                                      ? Colors.red
                                      : Colors.transparent,
                              controller: _profileController.username,
                              prefixIcon: FeatherIcons.user,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'İstifadəçi adı daxil edin';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (!value.isEmpty) {
                                  _profileController.isUsernameError.value =
                                      false;
                                  _profileController.isUsernameErrorText.value =
                                      "";
                                } else {
                                  _profileController.isUsernameError.value =
                                      true;
                                }
                              },
                            ),
                            sizedBoxHeight(height: 20),
                            CustomTextFormField(
                              hintText: "Email",
                              fillColor: fillColor,
                              borderColor: _profileController.isEmailError.value
                                  ? Colors.red
                                  : Colors.transparent,
                              controller: _profileController.email,
                              prefixIcon: FeatherIcons.mail,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email daxil edin';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (!value.isEmpty) {
                                  _profileController.isEmailError.value = false;
                                  _profileController.isEmailErrorText.value =
                                      "";
                                } else {
                                  _profileController.isEmailError.value = true;
                                }
                              },
                            ),
                            sizedBoxHeight(height: 20),
                            _buildDateField(),
                            sizedBoxHeight(height: 20),
                            Obx(
                              () => CustomButton(
                                isLoading: _profileController.isLoading.value,
                                text: "Yadda saxla",
                                onPressed: () {
                                  _profileController.editProfile();
                                },
                                fontSize: 17,
                                color: primaryColor,
                                textColor: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  DateTimeField _buildDateField() {
    return DateTimeField(
      controller: _profileController.birthday,
      format: DateFormat("dd.MM.yyyy"),
      style: poppinsTextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: "Doğum tarixi",
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
        prefixIcon: Icon(FeatherIcons.calendar, color: Color(0xFF9ba5b0)),
      ),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2100),
        );
      },
    );
  }

  Container _backgroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColor,
            primarySecondColor,
          ],
        ),
      ),
    );
  }
}
