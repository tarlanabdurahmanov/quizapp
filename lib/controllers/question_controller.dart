import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import '../constants/fonts.dart';
import 'home_controller.dart';
import '../core/controller/base_controller.dart';
import '../core/init/network/network_manager.dart';
import '../core/models/error_model.dart';
import '../models/QuestionResponseModel.dart';
import '../models/TimeOverResponseModel.dart';
import '../screens/home_screen.dart';
import '../service/NetworkService.dart';
import '../service/INetworkService.dart';
import 'package:confetti/confetti.dart';

class QuestionController extends BaseController
    with SingleGetTickerProviderMixin {
  var storage = GetStorage();

  INetworkService _service = NetworkService(CoreDio());

  AnimationController? _animationController;
  AnimationController? xpController;
  Animation? _animation;
  Animation? get animation => this._animation;
  AnimationController? get animationController => this._animationController;

  ConfettiController? confettiController;

  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();
  RxBool playing = false.obs;

  RxInt answerId = 0.obs;
  RxInt wrongAnswerId = 0.obs;
  RxInt changeScore = 0.obs;
  RxDouble changeHeight = 0.0.obs;

  Question? question;
  var answers = <QuestionAnswer>[].obs;
  var questionIndex = 0.obs;
  var examId = 0.obs;
  var score = 0.obs;
  var type = 0.obs;
  var isQuestionLoading = false.obs;
  var errorMessage = "".obs;

  @override
  void onInit() {
    xpController = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        update();
      });
    _animationController!.forward().whenComplete(whenComplete);
    super.onInit();
  }

  Future<void> getQuestions(int categoryId) async {
    changeLoading();
    try {
      final response = await _service.getQuestion(
        categoryId: categoryId,
      );
      if (response is QuestionResponseModel) {
        question = response.question;
        answers.value = response.answers;
      } else if (response is ErrorModel) {
        print("Error -> ${response.error}");
      }
      update();
    } catch (e) {
      print("Error -> ${e}");
    }
    changeLoading();
  }

  Future<void> checkAns(int id) async {
    isQuestionLoading.value = true;
    if (answerId.value == 0 && isQuestionLoading.value) {
      answerId.value = id;
      final response = await _service.userAnswer(answerId: answerId.value);
      if (response is QuestionResponseModel) {
        question = response.question;
        answers.value = response.answers;
        answerId.value = 0;
        ++changeScore.value;
        xpAnimation();
        Get.dialog(Lottie.asset("assets/lottie/excellent.json"));
      } else if (response is ErrorModel) {
        dynamic error = response.error;
        if (error['message'] != null) {
          wrongAnswerId.value = id;
          errorMessage.value = error['message'].toString();
          score.value = error['common_score'];
          storage.write("score", changeScore.value.toString());
          Get.dialog(
            Lottie.asset("assets/lottie/cry.json", width: 150, height: 150),
          );
        }
        if (error['type'] == 1) {
          ++changeScore.value;
          xpAnimation();
          type.value = 1;
          confettiController =
              ConfettiController(duration: const Duration(seconds: 40));
          confettiController!.play();
        }
      }
    }
    _animationController!.stop();
    await Future.delayed(Duration(seconds: 1));
    if (wrongAnswerId.value == 0) {
      nextQuestion();
      update();
    } else {
      showSnacbar(
        message: errorMessage.value.toString(),
        color: type.value == 1 ? Colors.green : null,
        icon: type.value == 1 ? FeatherIcons.check : null,
      );
      storage.write("score", score.value);
      Get.dialog(
        WillPopScope(
          onWillPop: () async {
            Get.delete<HomeController>();
            Get.offAll(() => HomeScreen());
            return false;
          },
          child: AlertDialog(
            title: Text(
              "Nəticə : ${score.value * 10} XP",
              style: poppinsTextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  errorMessage.value,
                  style: poppinsTextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
                if (type.value == 1)
                  Align(
                    alignment: Alignment.center,
                    child: ConfettiWidget(
                      confettiController: confettiController!,
                      blastDirectionality: BlastDirectionality.explosive,
                      shouldLoop: true,
                      blastDirection: pi,
                      particleDrag: 0.05,
                      emissionFrequency: 0.05,
                      numberOfParticles: 10,
                      gravity: 0.05,
                      colors: const [
                        Colors.green,
                        Colors.blue,
                        Colors.pink,
                        Colors.orange,
                        Colors.purple,
                      ],
                      createParticlePath: drawStar,
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.delete<HomeController>();
                  Get.offAll(() => HomeScreen());
                },
                child: Text("Ana Səhifə"),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );
    }
    isQuestionLoading.value = false;
  }

  void nextQuestion() {
    position = new Duration();
    duration = new Duration();
    _animationController!.reset();
    _animationController!.forward().whenComplete(whenComplete);
    update();
  }

  Future<void> getAudio(String url) async {
    if (playing.value) {
      var res = await audioPlayer.pause();
      if (res == 1) {
        playing.value = false;
      }
    } else {
      var res = await audioPlayer.play(url, isLocal: false);
      if (res == 1) {
        playing.value = true;
      }
    }

    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      position = dd;
    });

    audioPlayer.onDurationChanged.listen((Duration dd) {
      duration = dd;
    });

    audioPlayer.onPlayerStateChanged.listen((e) {
      if (e == PlayerState.PAUSED || e == PlayerState.COMPLETED) {
        playing.value = false;
      } else {
        playing.value = true;
      }
    });
    update();
  }

  Future<void> whenComplete() async {
    print("When Complete");
    final response = await _service.timeOver();
    if (response is TimeOverResponseModel) {
      Get.dialog(
        AlertDialog(
          title: Text(
            "Nəticə : ${response.success.commonScore}",
            style: poppinsTextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            response.success.message.toString(),
            style: poppinsTextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.delete<HomeController>();
                Get.offAll(() => HomeScreen());
              },
              child: Text("Ana Səhifə"),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    }
  }

  changeHeightFunc(double height) async {
    await Future.delayed(Duration(milliseconds: 1000));
    changeHeight.value = height;
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  xpAnimation() async {
    xpController!.reset();
    xpController!.forward();

    await Future.delayed(Duration(milliseconds: 300));
    xpController!.reverse();
    Get.back();
  }

  @override
  void onClose() {
    if (type.value == 1) {
      confettiController!.dispose();
    }
    audioPlayer.dispose();
    _animationController!.dispose();
    xpController!.dispose();
    super.onClose();
  }
}
