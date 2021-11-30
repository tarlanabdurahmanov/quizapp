import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/constants/fonts.dart';
import 'package:quizapp/screens/category_screen.dart';
import '../colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
              Text(
                "0 XP",
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xFFfdf04d),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=930&q=80",
              height: 50.0,
              width: 50.0,
              fit: BoxFit.cover,
            ),
          ),
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
          _button(text: "RANKING", onPressed: () {}),
          SizedBox(height: 20),
          _button(text: "AYARLAR", onPressed: () {}),
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
