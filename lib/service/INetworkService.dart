import 'package:quizapp/models/LoginRequestModel.dart';
import 'package:quizapp/models/RegisterRequestModel.dart';

abstract class INetworkService {
  final String loginPath = INetworkServicePath.LOGIN.rawValue;
  final String registerPath = INetworkServicePath.REGISTER.rawValue;
  final String getQuestionPath = INetworkServicePath.GET_QUESTION.rawValue;
  final String userAnswerPath = INetworkServicePath.USER_ANSWER.rawValue;

  Future<dynamic> login(LoginRequestModel model);
  Future<dynamic> register(RegisterRequestModel model);
  Future<dynamic> getQuestion({int categoryId});
  Future<dynamic> userAnswer({int answerId});
}

enum INetworkServicePath { LOGIN, REGISTER, GET_QUESTION, USER_ANSWER }

extension INetworkServicePathExtension on INetworkServicePath {
  String get rawValue {
    switch (this) {
      case INetworkServicePath.LOGIN:
        return '/login';
      case INetworkServicePath.REGISTER:
        return '/register';
      case INetworkServicePath.GET_QUESTION:
        return '/start-game';
      case INetworkServicePath.USER_ANSWER:
        return '/user-answer';
      default:
        return '/not-found';
    }
  }
}
