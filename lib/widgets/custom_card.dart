import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const CustomCard({Key? key, required this.child, this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: context.theme.colorScheme.background.withOpacity(0.1),
              offset: Offset(0.0, 0.0),
              blurRadius: 2,
              spreadRadius: 1,
            )
          ],
          color: context.theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(15)),
      child: child,
    );
  }
}
