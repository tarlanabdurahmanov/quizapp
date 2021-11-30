import 'package:flutter/material.dart';

const poppinsFont = "Poppins";
const nunitoFont = "Nunito";
const promptFont = "Prompt";
const josefinFont = "Josefin";

TextStyle defaultTextStyle({
  Color color = Colors.black,
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.normal,
  String fontFamily = nunitoFont,
}) {
  return TextStyle(
    fontFamily: fontFamily,
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

TextStyle poppinsTextStyle({
  Color color = Colors.black,
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.normal,
  String fontFamily = poppinsFont,
}) {
  return TextStyle(
    fontFamily: fontFamily,
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

TextStyle propmtTextStyle({
  Color color = Colors.black,
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.normal,
  String fontFamily = promptFont,
}) {
  return TextStyle(
    fontFamily: fontFamily,
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}
