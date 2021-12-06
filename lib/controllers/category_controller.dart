import 'package:get/get.dart';
import 'package:quizapp/core/controller/base_controller.dart';
import 'package:quizapp/core/init/network/network_manager.dart';
import 'package:quizapp/core/models/error_model.dart';
import 'package:quizapp/database/DatabaseHelper.dart';
import 'package:quizapp/models/CategoryResponseModel.dart';
import 'package:quizapp/service/INetworkService.dart';
import 'package:quizapp/service/NetworkService.dart';

class CategoryController extends BaseController {
  INetworkService _service = NetworkService(CoreDio());
  var categories = <Category>[].obs;
  String _categoryTable = "category";

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  Future<void> getCategories() async {
    changeLoading();
    categories.value = await DatabaseHelper.instance.getCategories();
    try {
      final response = await _service.getCategories();
      if (response is CategoryResponseModel) {
        if (categories.length < response.categories.length) {
          _deleteAll();
          response.categories.forEach((element) async {
            await DatabaseHelper.instance.add(
              table: _categoryTable,
              model: Category(
                id: element.id,
                categoryName: element.categoryName,
                image: element.image,
              ),
            );
          });
          categories.value = await DatabaseHelper.instance.getCategories();
        }
      } else if (response is ErrorModel) {}
    } catch (e) {
      print("E -> $e");
    }
    changeLoading();
  }

  Future<void> _deleteAll() async {
    await DatabaseHelper.instance.deleteAll(table: _categoryTable);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
