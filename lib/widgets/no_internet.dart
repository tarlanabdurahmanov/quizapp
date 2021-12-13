import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import '../constants/colors.dart';
import '../constants/fonts.dart';
import '../constants/size.dart';
import '../core/controller/network_controller.dart';
import 'custom_button.dart';

class NoInternetScreen extends StatelessWidget {
  final _networkController = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              "assets/svg/error3.svg",
              height: 300,
            ),
          ),
          Text(
            "İnternet bağlantısını yoxlayın",
            style: propmtTextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          sizedBoxHeight(height: 30),
          CustomButton(
            text: "Yenidən cəhd edin",
            onPressed: () {
              _networkController.initConnectivity(check: false);
            },
            color: primaryColor,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
