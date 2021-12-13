import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../constants/strings.dart';

class LottieLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(loadingLottiePath, height: 200);
  }
}
