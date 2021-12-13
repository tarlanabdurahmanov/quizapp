import 'package:flutter/material.dart';
import '../constants/fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? errorText;
  final Color fillColor;
  final Color borderColor;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  final VoidCallback? onTap;

  const CustomTextFormField(
      {Key? key,
      required this.hintText,
      this.errorText,
      required this.fillColor,
      required this.borderColor,
      required this.prefixIcon,
      this.onChanged,
      this.validator,
      required this.controller,
      this.obscureText = false,
      this.suffixIcon,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      cursorColor: Colors.black,
      style: poppinsTextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        errorText: errorText,
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        contentPadding: prefixIcon != null
            ? EdgeInsets.all(0)
            : EdgeInsets.symmetric(horizontal: 15),
        hintStyle: propmtTextStyle(color: Color(0xFF9ba5b0)),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Color(0xFF9ba5b0))
            : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
