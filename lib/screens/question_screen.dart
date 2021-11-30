import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/constants/fonts.dart';
import 'package:quizapp/constants/size.dart';
import 'package:quizapp/controllers/question_controller.dart';
import 'package:quizapp/models/QuestionOption.dart';
import 'package:quizapp/widgets/question_option_button.dart';
import '../colors.dart';
import '../widgets/linear_progress_widget.dart';

class QuestionScreen extends StatelessWidget {
  final int categoryId;
  QuestionScreen({Key? key, required this.categoryId}) : super(key: key);

  final _questionController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    _questionController.getQuestions(categoryId);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/money.png",
              width: 40,
            ),
            SizedBox(width: 10),
            Text(
              "100 XP",
              style: TextStyle(
                fontSize: 17,
                color: Color(0xFFfdf04d),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: _questionSection(constraints),
            ),
          );
        },
      ),
    );
  }

  Stack _questionSection(BoxConstraints constraints) {
    return Stack(
      children: [
        Container(
          height: constraints.maxHeight * 0.35,
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
        ),
        Positioned(
          top: 10,
          left: 0,
          bottom: 0,
          right: 0,
          child: SingleChildScrollView(
            child: GetBuilder<QuestionController>(
              builder: (controller) => controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : Column(
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
                              // Text(
                              //   "Qeustion 1",
                              //   style: TextStyle(
                              //       color: primaryColor,
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 18),
                              // ),
                              // SizedBox(height: 5),
                              // Divider(),

                              if (controller.question.image != null)
                                Center(
                                  child: Image.network(
                                    controller.question.image,
                                    fit: BoxFit.contain,
                                    height: 100,
                                  ),
                                ),
                              if (controller.question.music != null)
                                _audioQuestion(controller.question.music),
                              if (controller.question.image != null ||
                                  controller.question.music != null)
                                sizedBoxHeight(height: 15),
                              Text(
                                controller.question.question,
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
                            isWrong: _questionController.wrongAnswerId.value ==
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
                    ),
            ),
          ),
        )
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
