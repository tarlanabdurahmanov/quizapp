import 'package:get/get.dart';
import 'package:quizapp/core/controller/base_controller.dart';
import 'package:quizapp/core/init/network/network_manager.dart';
import 'package:quizapp/core/models/error_model.dart';
import 'package:quizapp/models/CategoryResponseModel.dart';
import 'package:quizapp/models/RatingResponseModel.dart';
import 'package:quizapp/service/INetworkService.dart';
import 'package:quizapp/service/NetworkService.dart';

class LeaderboardController extends BaseController {
  INetworkService _service = NetworkService(CoreDio());

  var ratings = <Rating>[].obs;

  @override
  void onInit() {
    getRatings();
    super.onInit();
  }

  Future<void> getRatings() async {
    changeLoading();
    final response = await _service.getRatings();
    print(response);
    if (response is RatingResponseModel) {
      ratings.value = response.rating;
    } else if (response is ErrorModel) {}
    changeLoading();
  }
}
