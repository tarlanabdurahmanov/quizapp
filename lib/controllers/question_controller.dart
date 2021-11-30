import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/constants/fonts.dart';
import 'package:quizapp/core/controller/base_controller.dart';
import 'package:quizapp/core/init/network/network_manager.dart';
import 'package:quizapp/core/models/error_model.dart';
import 'package:quizapp/models/QuestionResponseModel.dart';
import 'package:quizapp/screens/home_screen.dart';
import 'package:quizapp/service/NetworkService.dart';
import 'package:quizapp/service/INetworkService.dart';

class QuestionController extends BaseController
    with SingleGetTickerProviderMixin {
  INetworkService _service = NetworkService(CoreDio());

  AnimationController? _animationController;
  Animation? _animation;
  Animation? get animation => this._animation;
  AnimationController? get animationController => this._animationController;

  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();
  RxBool playing = false.obs;

  RxInt answerId = 0.obs;
  RxInt wrongAnswerId = 0.obs;

  late Question question;
  var answers = <QuestionAnswer>[].obs;
  var questionIndex = 0.obs;
  var examId = 0.obs;
  var score = 0.obs;
  var questionPosition = 1.obs;
  var isQuestionLoading = false.obs;

  var errorMessage = "".obs;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        update();
      });
    _animationController!.forward().whenComplete(nextQuestion);
    super.onInit();
  }

  Future<void> getQuestions(int categoryId) async {
    changeLoading();
    final response = await _service.getQuestion(
      categoryId: categoryId,
    );
    if (response is QuestionResponseModel) {
      question = response.question;
      answers.value = response.answers;
      print(question);
    } else if (response is ErrorModel) {
      print("Error -> ${response.error}");
    }
    update();
    changeLoading();
  }

  Future<void> checkAns(int id) async {
    changeQuestionLoading();
    if (answerId.value == 0 && isQuestionLoading.value) {
      answerId.value = id;
      final response = await _service.userAnswer(answerId: answerId.value);
      if (response is QuestionResponseModel) {
        question = response.question;
        answers.value = response.answers;
        answerId.value = 0;
      } else if (response is ErrorModel) {
        print("Response error ${response.error}");
        dynamic error = response.error;
        if (error['message'] != null) {
          wrongAnswerId.value = id;
          await Future.delayed(Duration(seconds: 1));
          showSnacbar(message: error['message'].toString());
          errorMessage.value = error['message'].toString();
          score.value = error['common_score'];
        }
      }
    }
    _animationController!.stop();
    await Future.delayed(Duration(seconds: 1));
    if (wrongAnswerId.value == 0) {
      nextQuestion();
      update();
    } else {
      Get.dialog(
        AlertDialog(
          title: Text(
            "Nəticə : ${score.value}",
            style: poppinsTextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            errorMessage.value,
            style: poppinsTextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.offAll(() => HomeScreen());
              },
              child: Text("Ana Səhifə"),
            ),
          ],
        ),
        barrierDismissible: false,
      );
      // Get.offAll(() => HomeScreen());
    }
    changeQuestionLoading();
  }

  changeQuestionLoading() {
    isQuestionLoading.value = !isQuestionLoading.value;
  }

  void nextQuestion() {
    position = new Duration();
    duration = new Duration();
    _animationController!.reset();
    _animationController!.forward().whenComplete(nextQuestion);
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

  @override
  void onClose() {
    super.onClose();
    audioPlayer.dispose();
    _animationController!.dispose();
  }
}
