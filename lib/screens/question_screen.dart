import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/widgets/animation_score.dart';
import 'package:quizapp/constants/fonts.dart';
import 'package:quizapp/constants/size.dart';
import 'package:quizapp/controllers/question_controller.dart';
import 'package:quizapp/models/QuestionOption.dart';
import 'package:quizapp/screens/home_screen.dart';
import 'package:quizapp/widgets/custom_button.dart';
import 'package:quizapp/widgets/lottie_loading.dart';
import 'package:quizapp/widgets/question_option_button.dart';
import '../constants/colors.dart';
import '../widgets/linear_progress_widget.dart';

// ignore: must_be_immutable
class QuestionScreen extends StatelessWidget {
  final int categoryId;
  QuestionScreen({Key? key, required this.categoryId}) : super(key: key);

  final _questionController = Get.put(QuestionController());
  var height = 0.0;
  @override
  Widget build(BuildContext context) {
    _questionController.getQuestions(categoryId);
    return WillPopScope(
      onWillPop: () async {
        // print("Click event");
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text('Oyundan çıxmaq istəyirsiz?',
                style: defaultTextStyle(fontWeight: FontWeight.bold)),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text("Xeyr",
                    style: defaultTextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600)),
              ),
              TextButton(
                onPressed: () => Get.offAll(() => HomeScreen()),
                child: Text("Hə",
                    style: defaultTextStyle(
                        color: primaryColor, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: primaryColor,
            automaticallyImplyLeading: false,
            title: Obx(
              () => ScaleTransition(
                scale: Tween(begin: 0.75, end: 1.0).animate(CurvedAnimation(
                    parent: _questionController.xpController!,
                    curve: Curves.fastLinearToSlowEaseIn)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/money.png",
                      width: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "${_questionController.changeScore.value * 10} XP",
                      style: propmtTextStyle(
                        fontSize: 15,
                        color: Color(0xFFfdf04d),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
            // title: Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset(
            //       "assets/images/money.png",
            //       width: 40,
            //     ),
            //     SizedBox(width: 10),
            //     Obx(
            //       () => Text(
            //         "${_questionController.changeScore.value * 10} XP",
            //         style: TextStyle(
            //           fontSize: 17,
            //           color: Color(0xFFfdf04d),
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            _questionController.changeHeightFunc(constraints.maxHeight * 0.35);
            return ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Obx(
                  () => _questionController.isLoading.value
                      ? LottieLoading()
                      : _questionSection(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Stack _questionSection() {
    return Stack(
      children: [
        Obx(
          () => AnimatedContainer(
            height: _questionController.changeHeight.value,
            clipBehavior: Clip.antiAlias,
            curve: Curves.fastLinearToSlowEaseIn,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  primaryColor,
                  primarySecondColor,
                ],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(600, 100),
              ),
            ),
            duration: Duration(milliseconds: 400),
          ),
        ),
        Positioned(
          top: 10,
          left: 0,
          bottom: 0,
          right: 0,
          child: SingleChildScrollView(
            child: GetBuilder<QuestionController>(
                builder: (controller) => controller.question != null
                    ? Column(
                        children: [
                          _progressSection(),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: Offset(0, 1),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (controller.question!.image != null)
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Image.network(
                                        controller.question!.image,
                                        fit: BoxFit.contain,
                                        height: 150,
                                      ),
                                    ),
                                  ),
                                if (controller.question!.music != null)
                                  _audioQuestion(controller.question!.music),
                                if (controller.question!.image != null ||
                                    controller.question!.music != null)
                                  sizedBoxHeight(height: 15),
                                Text(
                                  controller.question!.question,
                                  style: poppinsTextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          ...controller.answers.map((element) {
                            return QuestionOptionRadioButton(
                              option: QuestionOption(
                                  id: element.id, text: element.answer),
                              isSelect: _questionController.answerId.value ==
                                  element.id,
                              isWrong:
                                  _questionController.wrongAnswerId.value ==
                                      element.id,
                              selected: () {
                                if (_questionController.wrongAnswerId.value ==
                                        0 &&
                                    !_questionController
                                        .isQuestionLoading.value) {
                                  _questionController.checkAns(element.id);
                                }
                              },
                            );
                          })
                        ],
                      )
                    : Center(
                        child: Column(
                          children: [
                            Text(
                              "Sual tapılmadı",
                              style: propmtTextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            sizedBoxHeight(height: 20),
                            CustomButton(
                              text: "Ana səhifə",
                              onPressed: () {
                                Get.offAll(() => HomeScreen());
                              },
                            ),
                          ],
                        ),
                      )),
          ),
        ),
        if (_questionController.isLoading.value)
          Positioned(child: Center(child: LottieLoading()))
      ],
    );
  }

  Padding _progressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: LinearProgressIndicatorWidget(
        second: 60,
        animationController: _questionController.animationController!,
      ),
    );
  }

  Container _audioQuestion(String url) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: fillColor,
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            primarySecondColor,
            primaryColor,
          ],
        ),
      ),
      child: Row(
        children: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 15, right: 0),
              child: InkWell(
                onTap: () {
                  _questionController.getAudio(url);
                },
                child: Icon(
                  !_questionController.playing.value
                      ? Icons.play_circle_outline
                      : Icons.pause_circle_outline,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          sizedBoxWidth(width: 5),
          Text(
            "${_questionController.position.toString().split(".")[0].split(":")[1]}:${_questionController.position.toString().split(".")[0].split(":")[2]}/${_questionController.duration.toString().split(".")[0].split(":")[1]}:${_questionController.duration.toString().split(".")[0].split(":")[2]}",
            style: propmtTextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          Flexible(
            child: musicSlider(),
          ),
        ],
      ),
    );
  }

  Widget musicSlider() {
    return Slider.adaptive(
      activeColor: Colors.white.withOpacity(0.7),
      thumbColor: Colors.white,
      inactiveColor: Colors.white.withOpacity(0.2),
      min: 0.0,
      value: _questionController.position.inSeconds.toDouble(),
      max: _questionController.duration.inSeconds.toDouble(),
      onChanged: (double value) {
        _questionController.audioPlayer
            .seek(new Duration(seconds: value.toInt()));
      },
    );
  }
}
