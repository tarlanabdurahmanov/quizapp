import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final bool? isLoading;
  final Widget child;

  const CustomOutlineButton(
      {Key? key,
      required this.onPressed,
      this.fontSize,
      this.color,
      this.textColor,
      this.isLoading = false,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        elevation: 0,
        primary: textColor ?? Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
