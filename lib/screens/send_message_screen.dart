import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../constants/size.dart';
import '../controllers/send_message_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class SendMessageScreen extends StatelessWidget {
  final _sendMessageController = Get.put(SendMessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Text(
          "Mesaj göndər",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        hintText: "Mövzu...",
                        errorText: _sendMessageController
                                    .isSubjectErrorText.value ==
                                ""
                            ? null
                            : _sendMessageController.isSubjectErrorText.value,
                        fillColor: fillColor,
                        borderColor: _sendMessageController.isSubjectError.value
                            ? Colors.red
                            : Colors.transparent,
                        prefixIcon: null,
                        controller: _sendMessageController.subject,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mövzu adı daxil edin';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (!value.isEmpty) {
                            _sendMessageController.isSubjectError.value = false;
                            _sendMessageController.isSubjectErrorText.value =
                                "";
                          } else {
                            _sendMessageController.isSubjectError.value = true;
                          }
                        },
                      ),
                      sizedBoxHeight(),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mesaj daxil edin';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (!value.isEmpty) {
                            _sendMessageController.isSubjectError.value = false;
                            _sendMessageController.isSubjectErrorText.value =
                                "";
                          } else {
                            _sendMessageController.isSubjectError.value = true;
                          }
                        },
                        controller: _sendMessageController.message,
                        cursorColor: Colors.black,
                        style: poppinsTextStyle(fontWeight: FontWeight.w600),
                        minLines: 7,
                        maxLines: 50,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Mesaj...",
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          errorText: _sendMessageController
                                      .isSubjectErrorText.value ==
                                  ""
                              ? null
                              : _sendMessageController.isSubjectErrorText.value,
                          fillColor: fillColor,
                          hintStyle: propmtTextStyle(color: Color(0xFF9ba5b0)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color:
                                    _sendMessageController.isSubjectError.value
                                        ? Colors.red
                                        : Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color:
                                    _sendMessageController.isSubjectError.value
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
                                color:
                                    _sendMessageController.isSubjectError.value
                                        ? Colors.red
                                        : Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      sizedBoxHeight(),
                      CustomButton(
                        isLoading: _sendMessageController.isLoading.value,
                        text: "Göndər",
                        onPressed: () {
                          _sendMessageController.sendMessage();
                        },
                        fontSize: 17,
                        color: primaryColor,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
