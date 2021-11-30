import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/colors.dart';
import 'package:quizapp/screens/home_screen.dart';
import 'package:quizapp/uiwidgets/CustromButton.dart';
import 'package:quizapp/uiwidgets/NoInternet.dart';

class NetworkController extends GetxController {
  // ignore: cancel_subscriptions, unused_field
  StreamSubscription<ConnectivityResult>? _connectivityStreamSubscription;
  final Connectivity _connectivity = Connectivity();
  var storage = GetStorage();
  RxBool connection = false.obs;

  @override
  void onInit() {
    initConnectivity(check: false);
    _connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      _updateConnectionStatus(result, false);
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
    if (ConnectivityResult.none == result && check == false) {
      connection.value = false;
      await Future.delayed(Duration(seconds: 3));

      Get.deleteAll();
      Get.offAll(() => NoInternetScreen());
    } else if (check) {
      if (ConnectivityResult.none == result) {
        connection.value = false;
        Get.dialog(
          AlertDialog(
            title: Text("checkInternet".tr,
                style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomButton(
                  widget: Text('ok'.tr),
                  color: primaryColor,
                  onPressed: () {
                    if (ConnectivityResult.none != result) {
                      // Get.offAll(() => SplashScreen());
                    } else {
                      exit(0);
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
        Get.offAll(() => HomeScreen());
      }
    }
  }
}
