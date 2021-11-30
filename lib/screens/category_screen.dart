import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/constants/fonts.dart';
import 'package:quizapp/screens/question_screen.dart';
import '../colors.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Text(
          "Bölmələr",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          _backgroundGradient(),
          SafeArea(
            child: Column(
              children: [
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

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button(
            text: "Ümumi",
            onPressed: () {
              Get.to(() => QuestionScreen(categoryId: 1));
            },
          ),
          SizedBox(height: 20),
          _button(
            text: "Tarix",
            onPressed: () {
              Get.to(() => QuestionScreen(categoryId: 2));
            },
          ),
          SizedBox(height: 20),
          _button(
            text: "Futbol",
            onPressed: () {
              Get.to(() => QuestionScreen(categoryId: 3));
            },
          ),
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
        style: propmtTextStyle(
          color: Color(0xFF6b71df),
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    );
  }
}
