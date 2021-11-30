import 'package:flutter/material.dart';
import 'package:quizapp/constants/fonts.dart';
import 'package:quizapp/uiwidgets/CustromProgressIndicator.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final bool? isLoading;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.fontSize,
      this.color,
      this.textColor,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: color ?? Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: isLoading!
          ? CustomProgressIndicator(
              color: Colors.white,
            )
          : Text(
              text,
              style: propmtTextStyle(
                color: textColor ?? Color(0xFF6b71df),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
    );
  }
}
