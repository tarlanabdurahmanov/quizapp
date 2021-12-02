import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/constants/fonts.dart';
import 'package:quizapp/constants/strings.dart';
import 'package:quizapp/controllers/home_controller.dart';
import 'package:quizapp/screens/category_screen.dart';
import 'package:quizapp/screens/leaderboard_screen.dart';
import 'package:quizapp/screens/profile_screen.dart';
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
          Row(
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
          Obx(
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
          _logotext(),
          SizedBox(height: 60),
          _button(
            text: "OYNA",
            onPressed: () {
              Get.to(() => CategoryScreen());
            },
          ),
          SizedBox(height: 20),
          _button(
            text: "RANKING",
            onPressed: () {
              Get.to(() => LeaderBoardScreen());
            },
          ),
          SizedBox(height: 20),
          _button(
              text: "AYARLAR",
              onPressed: () {
                Get.to(() => ProfileScreen());
              }),
        ],
      ),
    );
  }

  ElevatedButton _button(
      {required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
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
