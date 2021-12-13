import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import '../core/controller/base_controller.dart';
import '../core/models/error_model.dart';
import '../models/LoginRequestModel.dart';
import '../models/AuthResponseModel.dart';
import '../screens/home_screen.dart';
import '../service/INetworkService.dart';
import '../service/NetworkService.dart';
import '../core/init/network/network_manager.dart';

class LoginController extends BaseController {
  INetworkService _service = NetworkService(CoreDio());

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool showPassword = false.obs;
  RxBool isUsernameError = false.obs;
  RxBool isPasswordError = false.obs;
  RxString isUsernameErrorText = "".obs;
  RxString isPasswordErrorText = "".obs;
  var storage = GetStorage();

  login() async {
    changeLoading();
    try {
      final response = await _service.login(
        LoginRequestModel(
          username: username.text.trim(),
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
    username.clear();
    password.clear();
    super.onClose();
  }
}
