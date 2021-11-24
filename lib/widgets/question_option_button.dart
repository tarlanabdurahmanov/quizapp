import 'package:flutter/material.dart';
import '../colors.dart';
import '../models/QuestionOption.dart';

class QuestionOptionRadioButton extends StatefulWidget {
  final int index;
  final QuestionOption option;

  const QuestionOptionRadioButton(
      {Key? key, required this.index, required this.option})
      : super(key: key);

  @override
  _QuestionOptionRadioButtonState createState() =>
      _QuestionOptionRadioButtonState();
}

class _QuestionOptionRadioButtonState extends State<QuestionOptionRadioButton> {
  bool _animate = false;
  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    _isStart
        ? Future.delayed(Duration(milliseconds: widget.index * 100), () {
            setState(() {
              _animate = true;
              _isStart = false;
            });
          })
        : _animate = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: widget.option.isCheck
              ? Colors.green
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
            decoration: !widget.option.isCheck
                ? ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(width: 2, color: primaryColor),
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.green,
                  ),
            child: !widget.option.isCheck
                ? null
                : Icon(Icons.check, color: Colors.white, size: 18),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              widget.option.text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: !widget.option.isCheck ? Colors.black87 : Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
