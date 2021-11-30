import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/screens/home_screen.dart';
import 'package:quizapp/screens/login_screen.dart';
import 'package:quizapp/uiwidgets/DismissFocusOverlay.dart';

void main() async {
  await GetStorage.init();
  var _storage = GetStorage();
  final _isLogin =
      _storage.read("isLogin") != null ? _storage.read("isLogin") : false;
  runApp(MyApp(isLogin: _isLogin));
}

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp({Key? key, required this.isLogin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DismissFocusOverlay(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        home: isLogin ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}
