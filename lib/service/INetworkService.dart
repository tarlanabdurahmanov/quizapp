import 'package:quizapp/models/LoginRequestModel.dart';
import 'package:quizapp/models/RegisterRequestModel.dart';

abstract class INetworkService {
  final String loginPath = INetworkServicePath.LOGIN.rawValue;
  final String registerPath = INetworkServicePath.REGISTER.rawValue;
  final String getQuestionPath = INetworkServicePath.GET_QUESTION.rawValue;
  final String userAnswerPath = INetworkServicePath.USER_ANSWER.rawValue;
  final String timeOverPath = INetworkServicePath.TIME_OVER.rawValue;
  final String getCategoriesPath = INetworkServicePath.GET_CATEGORIES.rawValue;
  final String ratingPath = INetworkServicePath.RATING.rawValue;

  Future<dynamic> login(LoginRequestModel model);
  Future<dynamic> register(RegisterRequestModel model);
  Future<dynamic> getQuestion({int categoryId});
  Future<dynamic> userAnswer({int answerId});
  Future<dynamic> timeOver();
  Future<dynamic> getCategories();
  Future<dynamic> getRatings();
}

enum INetworkServicePath {
  LOGIN,
  REGISTER,
  GET_QUESTION,
  USER_ANSWER,
  TIME_OVER,
  GET_CATEGORIES,
  RATING,
}

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
      case INetworkServicePath.TIME_OVER:
        return '/time-over';
      case INetworkServicePath.GET_CATEGORIES:
        return '/get-categories';
      case INetworkServicePath.RATING:
        return '/rating';
      default:
        return '/not-found';
    }
  }
}
