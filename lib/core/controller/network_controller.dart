import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'base_controller.dart';
import '../init/network/network_manager.dart';
import '../../screens/home_screen.dart';
import '../../service/INetworkService.dart';
import '../../service/NetworkService.dart';
import '../../widgets/no_internet.dart';

class NetworkController extends BaseController {
  INetworkService _service = NetworkService(CoreDio());
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
      print("_updateConnectionStatus 1-> $result");
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
    print("_updateConnectionStatus -2> $result");
    if (ConnectivityResult.none == result) {
      connection.value = false;
      Get.offAll(() => NoInternetScreen());
      showSnacbar(
          message: "İnternet bağlantısını yoxlayın", animationDuration: 3);
      await _service.timeOver();
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
