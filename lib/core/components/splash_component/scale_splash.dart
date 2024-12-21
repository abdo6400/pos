import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScaleSplash extends StatefulWidget {
  ScaleSplash({super.key});
  Color? backgroundColor;
  double scale = 0;
  VoidCallback? onScaleEnd;
  Widget? scaleChildWidget;
  Duration? scaleAnimationDuration;
  Curve? animationCurve = Curves.ease;
  Image? backgroundImage;
  Gradient? gradient;
  String?title;

  @override
  State<ScaleSplash> createState() => _ScaleSplashState();
}

class _ScaleSplashState extends State<ScaleSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          image: widget.backgroundImage != null
              ? DecorationImage(
                  image: widget.backgroundImage!.image,
                  fit: BoxFit.fill,
                )
              : null,
          gradient: widget.gradient,
        ),
        child: Center(
          child: AnimatedScale(
            scale: widget.scale,
            curve: widget.animationCurve!,
            onEnd: widget.onScaleEnd,
            duration: widget.scaleAnimationDuration!,
            child: widget.scaleChildWidget,
          ),
        ),
      ),
    );
  }
}
