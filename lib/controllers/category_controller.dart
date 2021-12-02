import 'package:get/get.dart';
import 'package:quizapp/core/controller/base_controller.dart';
import 'package:quizapp/core/init/network/network_manager.dart';
import 'package:quizapp/core/models/error_model.dart';
import 'package:quizapp/models/CategoryResponseModel.dart';
import 'package:quizapp/service/INetworkService.dart';
import 'package:quizapp/service/NetworkService.dart';

class CategoryController extends BaseController {
  INetworkService _service = NetworkService(CoreDio());
  var categories = <Category>[].obs;

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> getCategories() async {
    changeLoading();
    final response = await _service.getCategories();
    if (response is CategoryResponseModel) {
      categories.value = response.categories;
    } else if (response is ErrorModel) {
    }
    changeLoading();
  }
}
