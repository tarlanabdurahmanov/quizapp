import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'home_controller.dart';
import '../core/controller/base_controller.dart';
import '../core/init/network/network_manager.dart';
import '../core/models/error_model.dart';
import '../screens/home_screen.dart';
import '../service/INetworkService.dart';
import '../service/NetworkService.dart';
import 'package:dio/dio.dart' as Dio;

class ProfileController extends BaseController {
  INetworkService _service = NetworkService(CoreDio());
  TextEditingController username = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController birthday = TextEditingController();
  var storage = GetStorage();
  final ImagePicker _picker = ImagePicker();

  RxString profileImage = "".obs;
  RxString imagePath = "".obs;
  RxString isUsernameErrorText = "".obs;
  RxString isEmailErrorText = "".obs;

  RxBool isImage = false.obs;
  RxBool isUsernameError = false.obs;
  RxBool isEmailError = false.obs;

  @override
  void onInit() {
    user();
    super.onInit();
  }

  Future<void> getImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      print(pickedFile);
      if (pickedFile != null) {
        imagePath.value = pickedFile.path;
        isImage.value = true;
        update();
      }
    } catch (e) {
      print("e -> ${e}");
    }
  }

  Future<void> user() async {
    dynamic user = storage.read("user");
    username.text = user['username'];
    name.text = user['name'] ?? "";
    email.text = user['email'];
    if (user['birthday'] != null) {
      birthday.text =
          DateFormat("dd.MM.yyyy").format(DateTime.parse(user['birthday']));
    }
    profileImage.value = user['profile_image'] ?? "";
  }

  Future<void> editProfile() async {
    changeLoading();
    Dio.FormData _formData = new Dio.FormData.fromMap({
      "email": email.text,
      "username": username.text,
      "name": name.text,
      "birthday": birthday.text,
      "profile_image": isImage.value
          ? Dio.MultipartFile.fromFileSync(imagePath.value,
              filename: imagePath.value)
          : null,
    });

    final response = await _service.editProfile(_formData);
    if (response is ErrorModel) {
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

      if (error["message"] != null) {
        isUsernameErrorText.value = error["message"];
        showSnacbar(message: error["message"]);
      }
    } else {
      Get.delete<HomeController>();
      Get.offAll(() => HomeScreen());
      showSnacbar(
        message: "Profil yeniləndi",
        color: Colors.green,
        icon: FeatherIcons.check,
      );
    }
    changeLoading();
  }
}
