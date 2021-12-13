import 'package:animate_do/animate_do.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import '../constants/fonts.dart';
import '../constants/strings.dart';
import '../controllers/home_controller.dart';
import 'category_screen.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';
import 'send_message_screen.dart';
import '../constants/colors.dart';

class HomeScreen extends StatelessWidget {
  final _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundGradient(),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Spacer(),
                _buildBody(context),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _backgroundGradient() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryColor,
            primarySecondColor,
          ],
        ),
      ),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FadeInLeft(
            child: Row(
              children: [
                Image.asset(
                  "assets/images/money.png",
                  width: 40,
                ),
                SizedBox(width: 10),
                Obx(
                  () => Text(
                    "${_homeController.score.value * 10} XP",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xFFfdf04d),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          FadeInRight(
            child: Obx(
              () => AvatarView(
                radius: 25,
                borderWidth: 1,
                avatarType: AvatarType.CIRCLE,
                backgroundColor: Colors.red,
                imagePath: _homeController.profileImage.value != ""
                    ? "${_homeController.profileImage.value}"
                    : userDefaultPath,
                placeHolder: Image.asset(userDefaultPath),
                errorWidget: Container(
                  child: Icon(
                    Icons.error,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ZoomIn(
            child: _logotext(),
          ),
          SizedBox(height: 60),
          _button(
            index: 700,
            text: "Oyna",
            onPressed: () {
              Get.to(() => CategoryScreen());
            },
          ),
          SizedBox(height: 20),
          _button(
            index: 1000,
            text: "Sıralama",
            onPressed: () {
              Get.to(() => LeaderBoardScreen());
            },
          ),
          SizedBox(height: 20),
          _button(
              index: 1400,
              text: "Ayarlar",
              onPressed: () {
                Get.to(() => ProfileScreen());
              }),
          SizedBox(height: 20),
          _button(
              index: 1400,
              text: "Mesaj Göndər",
              onPressed: () {
                Get.to(() => SendMessageScreen());
              }),
        ],
      ),
    );
  }

  Widget _button(
      {required String text,
      required VoidCallback onPressed,
      required int index}) {
    return FadeInUp(
      duration: Duration(milliseconds: index),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Text(
          text,
          style: defaultTextStyle(
            color: Color(0xFF6b71df),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Center _logotext() {
    return Center(
      child: Text(
        "Milyonçu",
        style: propmtTextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
