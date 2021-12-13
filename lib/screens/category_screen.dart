import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../constants/fonts.dart';
import '../constants/size.dart';
import '../constants/strings.dart';
import '../controllers/category_controller.dart';
import 'question_screen.dart';
import '../widgets/lottie_loading.dart';
import '../constants/colors.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
                  // SvgPicture.asset(
                  //   choosePath,
                  //   height: 200,
                  // ),
                  // sizedBoxHeight(height: 40),
                  // _categoryController
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _categoryController.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FadeInUp(
                        duration: Duration(milliseconds: index * 200),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: _button(
                            text: _categoryController
                                .categories[index].categoryName,
                            image: _categoryController.categories[index].image,
                            onPressed: () {
                              Get.to(() => QuestionScreen(
                                  categoryId: _categoryController
                                      .categories[index].id));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            : LottieLoading(),
      ),
    );
  }

  ElevatedButton _button(
      {required String text, String? image, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: image != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (image != null)
            SizedBox(
              width: 45,
              height: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(image),
              ),
            ),
          Text(
            text,
            style: propmtTextStyle(
              color: Color(0xFF6b71df),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          if (image != null) sizedBoxWidth(width: 40),
        ],
      ),
    );
  }
}
