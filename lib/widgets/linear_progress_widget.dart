import 'package:flutter/material.dart';
import '../colors.dart';

class LinearProgressIndicatorWidget extends StatefulWidget {
  const LinearProgressIndicatorWidget(
      {Key? key, required this.second, required this.animationController})
      : super(key: key);
  final int second;
  final AnimationController animationController;
  @override
  State<LinearProgressIndicatorWidget> createState() =>
      _LinearProgressIndicatorWidgetState();
}

class _LinearProgressIndicatorWidgetState
    extends State<LinearProgressIndicatorWidget> with TickerProviderStateMixin {
  Animation? animation;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 60),
    vsync: this,
  )..forward();

  // ignore: unused_field
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );
  @override
  void initState() {
    super.initState();
    animation =
        Tween<double>(begin: 0, end: 1).animate(widget.animationController)
          ..addListener(() {
            setState(() {});
          });

    // widget.animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxWidth * animation!.value,
              height: 35,
              decoration: animation!.value < 0.1
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: kPrimaryGradient,
                    )
                  : BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.circular(50),
                    ),
            ),
          ),
          Positioned(
            child: Container(
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.ac_unit, color: Colors.transparent),
                  Text(
                    "${(animation!.value * widget.second).round()} saniye",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.timelapse, color: Colors.white),
                ],
              ),
            ),
          ),
          Positioned(
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
