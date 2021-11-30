import 'dart:io';

import 'package:quizapp/models/LoginRequestModel.dart';
import 'package:quizapp/models/AuthResponseModel.dart';
import 'package:quizapp/models/QuestionResponseModel.dart';
import 'package:quizapp/models/RegisterRequestModel.dart';
import 'package:quizapp/models/TimeOverResponseModel.dart';
import 'package:quizapp/service/INetworkService.dart';

import '../../../../core/init/network/network_manager.dart';
import '../../core/models/error_model.dart';

class NetworkService extends INetworkService {
  final CoreDio dio;
  NetworkService(this.dio);

  @override
  Future<dynamic> login(LoginRequestModel model) async {
    final response = await coreDio.post(loginPath, model);

    if (response.statusCode == HttpStatus.ok) {
      return AuthResponseModel.fromJson(response.data['success']);
    } else {
      return ErrorModel.fromJson(response.data);
    }
  }

  @override
  Future register(RegisterRequestModel model) async {
    final response = await coreDio.post(registerPath, model);
    if (response.statusCode == HttpStatus.ok) {
      return AuthResponseModel.fromJson(response.data['success']);
    } else {
      return ErrorModel.fromJson(response.data);
    }
  }

  @override
  Future getQuestion({int? categoryId}) async {
    final response =
        await coreDio.post(getQuestionPath, {"category_id": categoryId});
    if (response.statusCode == HttpStatus.ok) {
      return QuestionResponseModel.fromJson(response.data['success']);
    } else {
      return ErrorModel.fromJson(response.data);
    }
  }

  @override
  Future userAnswer({int? answerId}) async {
    final response =
        await coreDio.post(userAnswerPath, {"answer_id": answerId});
    if (response.statusCode == HttpStatus.ok) {
      return QuestionResponseModel.fromJson(response.data['success']);
    } else {
      return ErrorModel.fromJson(response.data);
    }
  }

  @override
  Future timeOver() async {
    final response = await coreDio.post(timeOverPath, {});
    if (response.statusCode == HttpStatus.ok) {
      return TimeOverResponseModel.fromJson(response.data);
    } else {
      return ErrorModel.fromJson(response.data);
    }
  }
}
