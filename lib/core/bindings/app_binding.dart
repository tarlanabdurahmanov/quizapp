import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/controllers/category_controller.dart';

import '../controller/network_controller.dart';

class AppBinding extends Bindings {
  var storage = GetStorage();

  @override
  void dependencies() {
    var token = storage.read("token");
    Get.put<NetworkController>(NetworkController());

    if (token != null) {
      Get.put<CategoryController>(CategoryController());
    }
  }
}
