import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? color;
  final double? scala;

  const CustomProgressIndicator({Key? key, this.color, this.scala})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 25,
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              strokeWidth: 3,
              color: color ?? Colors.grey,
            )
          : CupertinoActivityIndicator(),
    );
  }
}
