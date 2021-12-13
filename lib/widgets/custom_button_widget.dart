import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final Widget widget;
  final Color color;
  final Color? borderColor;
  final VoidCallback onPressed;
  final double? radius;

  const CustomButtonWidget(
      {Key? key,
      required this.widget,
      required this.color,
      required this.onPressed,
      this.radius,
      this.borderColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        elevation: 0,
        shadowColor: color,
        padding: EdgeInsets.all(13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10),
          side: BorderSide(color: borderColor ?? primaryColor),
        ),
      ),
      onPressed: onPressed,
      child: widget,
    );
  }
}
