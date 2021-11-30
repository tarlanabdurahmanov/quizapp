import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../controller/network_controller.dart';
import '../../enum/network_route_enum.dart';

final Dio dio = new Dio(BaseOptions(
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
    validateStatus: (_) => true))
  ..options.baseUrl = NetworkRoutes.BASE_URL_PROD_ONE.rawValue
  ..options.connectTimeout = 150000
  ..options.receiveTimeout
  ..options.headers = {
    "Accept": "application/json",
  }
  ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
    final storage = GetStorage();
    var token = storage.read("token");
    options.headers.putIfAbsent("Authorization", () => "Bearer $token");
    return handler.next(options);
  }, onResponse: (response, handler) {
    return handler.next(response);
  }, onError: (DioError e, handler) {
    if (e.type == DioErrorType.other) {
      NetworkController().initConnectivity(check: true);
    }
    return handler.next(e);
  }));

class CoreDio {
  Future<dynamic> post(String url, dynamic data) async {
    return await dio.post(url, data: data);
  }

  Future<dynamic> get(String url) async {
    return await dio.get(url);
  }
}

final CoreDio coreDio = new CoreDio();
