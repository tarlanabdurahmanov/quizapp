import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/colors.dart';
import 'package:quizapp/core/controller/base_controller.dart';
import 'package:quizapp/screens/home_screen.dart';
import 'package:quizapp/uiwidgets/CustromButton.dart';
import 'package:quizapp/widgets/no_internet.dart';

class NetworkController extends BaseController {
  // ignore: cancel_subscriptions, unused_field
  StreamSubscription<ConnectivityResult>? _connectivityStreamSubscription;
  final Connectivity _connectivity = Connectivity();
  var storage = GetStorage();
  RxBool connection = false.obs;

  @override
  void onInit() {
    initConnectivity(check: true);
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      _updateConnectionStatus(result, true);
    });
    super.onInit();
  }

  Future<void> initConnectivity({required bool check}) async {
    ConnectivityResult? result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return _updateConnectionStatus(result, check);
  }

  _updateConnectionStatus(ConnectivityResult? result, bool check) async {
    if (check && ConnectivityResult.none == result) {
      connection.value = false;

      Get.offAll(() => NoInternetScreen());
      showSnacbar(
          message: "İnternet bağlantısını yoxlayın", animationDuration: 3);
    } else if (ConnectivityResult.none == result && !check) {
      showSnacbar(
          message: "İnternet bağlantısını yoxlayın", animationDuration: 3);
      Get.dialog(
        AlertDialog(
          title: Text("İnternet bağlantısını yoxlayın",
              style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                widget: Text('Tamam'),
                color: primaryColor,
                onPressed: () {
                  if (connection.value) {
                    Get.offAll(() => HomeScreen());
                  } else {
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
        barrierDismissible: false,
        barrierColor: Colors.black54,
      );
    } else {
      connection.value = true;
      if (!check) {
        Get.offAll(HomeScreen());
        showSnacbar(
          message: "İnternetə bağlandınız",
          animationDuration: 3,
          color: Colors.green,
          icon: FeatherIcons.check,
        );
      }
    }
  }
}
