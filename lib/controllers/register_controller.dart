import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/core/controller/base_controller.dart';
import 'package:quizapp/core/models/error_model.dart';
import 'package:quizapp/models/AuthResponseModel.dart';
import 'package:quizapp/models/RegisterRequestModel.dart';
import 'package:quizapp/screens/home_screen.dart';
import 'package:quizapp/service/INetworkService.dart';
import 'package:quizapp/service/NetworkService.dart';
import '../core/init/network/network_manager.dart';

class RegisterController extends BaseController {
  INetworkService _service = NetworkService(CoreDio());

  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  RxBool showPassword = false.obs;
  RxBool isUsernameError = false.obs;
  RxBool isEmailError = false.obs;
  RxBool isPasswordError = false.obs;
  RxString isUsernameErrorText = "".obs;
  RxString isEmailErrorText = "".obs;
  RxString isPasswordErrorText = "".obs;
  var storage = GetStorage();

  void register() async {
    changeLoading();
    try {
      final response = await _service.register(
        RegisterRequestModel(
          name: name.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          password: password.text.trim(),
        ),
      );
      if (response is AuthResponseModel) {
        storage.write("token", response.token);
        storage.write("isLogin", true);
        Get.offAll(() => HomeScreen());
      } else if (response is ErrorModel) {
        dynamic error = response.error;
        if (error["username"] != null) {
          isUsernameError.value = true;
          isUsernameErrorText.value = error["username"][0];
          showSnacbar(message: error["username"][0]);
        }
        if (error["email"] != null) {
          isEmailError.value = true;
          isEmailErrorText.value = error["email"][0];
          showSnacbar(message: error["email"][0]);
        }
        if (error["password"] != null) {
          isPasswordError.value = true;
          isPasswordErrorText.value = error["password"][0];
          showSnacbar(message: error["password"][0]);
        }
        if (error["message"] != null) {
          isUsernameErrorText.value = error["message"];
          showSnacbar(message: error["message"]);
        }
      }
    } catch (e) {
      print("Error --> $e");
    }
    changeLoading();
  }

  @override
  void onClose() {
    // ignore: invalid_use_of_protected_member
    username.dispose();
    email.dispose();
    password.dispose();
    isUsernameError.value = false;
    isEmailError.value = false;
    isPasswordError.value = false;
    super.onClose();
  }
}
