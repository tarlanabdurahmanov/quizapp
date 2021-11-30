import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/constants/fonts.dart';
import 'package:quizapp/constants/size.dart';
import 'package:quizapp/controllers/question_controller.dart';
import '../colors.dart';
import '../models/QuestionOption.dart';
import '../widgets/question_option_button.dart';

class QuizScreen extends StatelessWidget {
  final _quizController = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: TextButton(
          child: Text(
            "Next",
            style: TextStyle(
              fontSize: 17,
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {},
        ),
      ),
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
              child: Stack(
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
                      child: Obx(
                        () => Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              // child: LinearProgressIndicatorWidget(second: 10),
                            ),
                            SizedBox(height: 20),
                            Container(
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
                                  Text(
                                    "Qeustion 1",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(height: 5),
                                  Divider(),
                                  SizedBox(height: 5),
                                  Center(
                                    child: Image.network(
                                      "http://94.20.38.107:8002/storage/question/ztgR6QySZafxCeBT6KpLS1uWw096fCEdsasecEcq.png",
                                      fit: BoxFit.contain,
                                      height: 100,
                                    ),
                                  ),
                                  sizedBoxHeight(height: 15),
                                  Text(
                                    """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.""",
                                    style: poppinsTextStyle(
                                      // fontFamily: nunitoFont,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            ...radioList.map(
                              (e) => QuestionOptionRadioButton(
                                option: e,
                                isSelect:
                                    _quizController.answerId.value == e.id,
                                selected: () {
                                  _quizController.answerId.value = e.id;
                                },
                              ),
                            ),
                            // QuestionOptionRadioButton(
                            //   index: 0,
                            //   option: radioList[0],
                            //   isSelect: false,
                            // ),
                            // QuestionOptionRadioButton(
                            //   index: 1,
                            //   option: radioList[1],
                            //   isSelect: false,
                            // ),
                            // QuestionOptionRadioButton(
                            //   index: 2,
                            //   option: radioList[2],
                            //   isSelect: false,
                            // ),
                            // QuestionOptionRadioButton(
                            //   index: 3,
                            //   option: radioList[3],
                            //   isSelect: false,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
