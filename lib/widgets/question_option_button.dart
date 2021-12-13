import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../constants/fonts.dart';
import '../constants/colors.dart';
import '../models/QuestionOption.dart';

class QuestionOptionRadioButton extends StatefulWidget {
  final QuestionOption option;
  final bool isSelect;
  final bool isWrong;
  final VoidCallback selected;

  const QuestionOptionRadioButton(
      {Key? key,
      required this.option,
      this.isSelect = false,
      this.isWrong = false,
      required this.selected})
      : super(key: key);

  @override
  _QuestionOptionRadioButtonState createState() =>
      _QuestionOptionRadioButtonState();
}

class _QuestionOptionRadioButtonState extends State<QuestionOptionRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.selected,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: widget.isSelect
                ? (widget.isWrong ? Colors.red : Colors.green)
                : Colors.grey.withOpacity(.2),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: !widget.isSelect
                  ? ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(width: 2, color: primaryColor),
                      ),
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: (widget.isWrong ? Colors.red : Colors.green),
                    ),
              child: !widget.isSelect
                  ? null
                  : Icon((widget.isWrong ? FeatherIcons.x : FeatherIcons.check),
                      color: Colors.white, size: 18),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                widget.option.text,
                style: poppinsTextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
