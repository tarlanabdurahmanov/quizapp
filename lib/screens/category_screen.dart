import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quizapp/constants/fonts.dart';
import 'package:quizapp/constants/size.dart';
import 'package:quizapp/constants/strings.dart';
import 'package:quizapp/controllers/category_controller.dart';
import 'package:quizapp/screens/question_screen.dart';
import 'package:quizapp/widgets/lottie_loading.dart';
import '../constants/colors.dart';

class CategoryScreen extends StatelessWidget {
  final _categoryController = Get.put(CategoryController());

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
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(child: _buildBody(context)),
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
      child: Obx(
        () => !_categoryController.isLoading.value
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    choosePath,
                    height: 200,
                  ),
                  sizedBoxHeight(height: 40),
                  if (_categoryController.isLoading.value)
                    Center(
                        child: CircularProgressIndicator(color: Colors.white)),
                  if (!_categoryController.isLoading.value)
                    ..._categoryController.categories.map(
                      (element) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: _button(
                          text: element.categoryName,
                          onPressed: () {
                            Get.to(
                                () => QuestionScreen(categoryId: element.id));
                          },
                        ),
                      ),
                    ),
                ],
              )
            : LottieLoading(),
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
