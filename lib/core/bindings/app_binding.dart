import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controller/network_controller.dart';

class AppBinding extends Bindings {
  var storage = GetStorage();
  @override
  void dependencies() {
    Get.put<NetworkController>(NetworkController());
  }
}
