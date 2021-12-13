import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/category_controller.dart';

import '../controller/network_controller.dart';

class AppBinding extends Bindings {
  var storage = GetStorage();

  @override
  void dependencies() {
    Get.put<NetworkController>(NetworkController());

    var token = storage.read("token");
    if (token != null) {
      Get.put<CategoryController>(CategoryController());
    }
  }
}
