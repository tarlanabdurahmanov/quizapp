import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/fonts.dart';
import '../constants/colors.dart';
import '../core/controller/base_controller.dart';
import '../core/init/network/network_manager.dart';
import '../core/models/error_model.dart';
import '../models/CategoryResponseModel.dart';
import '../models/RatingResponseModel.dart';
import '../service/INetworkService.dart';
import '../service/NetworkService.dart';
import '../widgets/custom_outline_button.dart';
import '../screens/home_screen.dart';

class LeaderboardController extends BaseController {
  INetworkService _service = NetworkService(CoreDio());

  var ratings = <Rating>[].obs;
  var categories = <Category>[].obs;

  @override
  void onInit() {
    alertRatings();
    super.onInit();
  }

  Future<void> alertRatings() async {
    changeLoading();
    final response = await _service.getCategories();
    print(response);
    if (response is CategoryResponseModel) {
      categories.value = response.categories;
      Get.dialog(
        WillPopScope(
          onWillPop: () async {
            Get.offAll(() => HomeScreen());
            return false;
          },
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "Bölmə seçin",
              style: propmtTextStyle(
                color: Color(0xFF6b71df),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            content: Container(
              width: double.maxFinite,
              height: 250,
              child: ListView(
                shrinkWrap: true,
                children: [
                  ...categories.map(
                    (element) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CustomOutlineButton(
                        textColor: primaryColor,
                        child: Text(element.categoryName),
                        onPressed: () {
                          getRatings(element.id);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.offAll(() => HomeScreen());
                },
                child: Text("Geri Dön"),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center,
          ),
        ),
        barrierDismissible: false,
      );
    } else if (response is ErrorModel) {}
    changeLoading();
  }

  Future<void> getRatings(int categoryId) async {
    changeLoading();
    final response = await _service.getRatings(categoryId);
    print(response);
    if (response is RatingResponseModel) {
      ratings.value = response.rating;
    } else if (response is ErrorModel) {}
    changeLoading();
    Get.back();
  }
}
