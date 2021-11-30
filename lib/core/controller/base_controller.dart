import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  RxBool isLoading = false.obs;
  showSnacbar({
    Color? color,
    required String message,
    IconData? icon,
    Color? iconColor,
  }) {
    Get.showSnackbar(
      GetBar(
        message: message,
        backgroundColor: color ?? Colors.red,
        duration: Duration(seconds: 3),
        icon: Icon(icon ?? FeatherIcons.alertCircle,
            color: iconColor ?? Colors.white),
        shouldIconPulse: false,
      ),
    );
  }

  changeLoading() async {
    isLoading.value = !isLoading.value;
  }
}
