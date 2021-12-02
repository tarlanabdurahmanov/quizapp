import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:quizapp/core/controller/base_controller.dart';
import 'package:quizapp/core/init/network/network_manager.dart';
import 'package:quizapp/models/UserResponseModel.dart';
import 'package:quizapp/service/INetworkService.dart';
import 'package:quizapp/service/NetworkService.dart';

class HomeController extends BaseController {
  INetworkService _service = NetworkService(CoreDio());
  var storage = GetStorage();
  var score = 0.obs;
  var profileImage = "".obs;

  @override
  void onInit() {
    user();
    super.onInit();
  }

  Future<void> user() async {
    score.value = storage.read("score") != null ? storage.read("score") : 0;
    print("User ->");
    print("User -> ${storage.read("score")}");
    final response = await _service.userInformation();
    if (response is UserResponseModel) {
      storage.write("user", response.user.toJson());
      profileImage.value = response.user.profileImage ?? "";
    }
  }
}
