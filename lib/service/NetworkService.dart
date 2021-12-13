import 'dart:io';

import '../models/CategoryResponseModel.dart';
import '../models/LoginRequestModel.dart';
import '../models/AuthResponseModel.dart';
import '../models/MessageRequestModel.dart';
import '../models/QuestionResponseModel.dart';
import '../models/RatingResponseModel.dart';
import '../models/RegisterRequestModel.dart';
import '../models/TimeOverResponseModel.dart';
import '../models/UserResponseModel.dart';
import 'INetworkService.dart';

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

  @override
  Future getCategories() async {
    final response = await coreDio.post(getCategoriesPath, {});
    if (response.statusCode == HttpStatus.ok) {
      return CategoryResponseModel.fromJson(response.data['success']);
    } else {
      return ErrorModel.fromJson(response.data);
    }
  }

  @override
  Future getRatings(int categoryId) async {
    final response = await coreDio.post(ratingPath, {
      "category_id": categoryId,
    });
    if (response.statusCode == HttpStatus.ok) {
      return RatingResponseModel.fromJson(response.data['success']);
    } else {
      return ErrorModel.fromJson(response.data);
    }
  }

  @override
  Future userInformation() async {
    final response = await coreDio.post(userInformationPath, {});
    if (response.statusCode == HttpStatus.ok) {
      return UserResponseModel.fromJson(response.data['success']);
    } else {
      return ErrorModel.fromJson(response.data);
    }
  }

  @override
  Future editProfile(data) async {
    final response = await coreDio.post(editProfilePath, data);
    if (response.statusCode == HttpStatus.ok) {
      return response.data['success'];
    } else {
      return ErrorModel.fromJson(response.data);
    }
  }

  @override
  Future sendMessage(MessageRequestModel model) async {
    final response = await coreDio.post(sendMessagePath, model);
    if (response.statusCode == HttpStatus.ok) {
      return response.data['success'];
    } else {
      return ErrorModel.fromJson(response.data);
    }
  }
}
