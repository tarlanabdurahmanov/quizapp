import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import '../core/controller/base_controller.dart';
import '../core/init/network/network_manager.dart';
import '../core/models/error_model.dart';
import '../models/MessageRequestModel.dart';
import '../screens/home_screen.dart';
import '../service/INetworkService.dart';
import '../service/NetworkService.dart';

class SendMessageController extends BaseController {
  INetworkService _service = NetworkService(CoreDio());

  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();

  RxBool isSubjectError = false.obs;
  RxString isSubjectErrorText = "".obs;
  RxBool isMessageError = false.obs;
  RxString isMessageErrorText = "".obs;

  sendMessage() async {
    changeLoading();
    try {
      final response = await _service.sendMessage(
        MessageRequestModel(
          subject: subject.text.trim(),
          message: message.text.trim(),
        ),
      );
      if (response is ErrorModel) {
        dynamic error = response.error;
        if (error["subject"] != null) {
          isSubjectError.value = true;
          isSubjectErrorText.value = error["subject"][0];
          showSnacbar(message: error["subject"][0]);
        }
        if (error["message"] != null) {
          isMessageError.value = true;
          isMessageErrorText.value = error["message"][0];
          showSnacbar(message: error["message"][0]);
        }
        if (error["message"] != null) {
          isSubjectErrorText.value = error["message"];
          showSnacbar(message: error["message"]);
        }
      } else {
        showSnacbar(
          message: "Mesaj göndərildi",
          color: Colors.green,
          icon: FeatherIcons.check,
        );
        Get.offAll(() => HomeScreen());
      }
    } catch (e) {
      print("Error --> $e");
    }
    changeLoading();
  }

  @override
  void onClose() {
    subject.clear();
    message.clear();
    super.onClose();
  }
}
