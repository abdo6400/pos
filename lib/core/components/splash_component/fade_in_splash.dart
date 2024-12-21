import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FadeInSplash extends StatefulWidget {
  FadeInSplash({super.key});
  Color? backgroundColor;
  double opacity = 0;
  VoidCallback? onFadeInEnd;
  Widget? fadeInChildWidget;
  Duration? fadeInAnimationDuration;
  Curve? animationCurve = Curves.ease;
  Image? backgroundImage;
  Gradient? gradient;
  String?title;

  @override
  State<FadeInSplash> createState() => _FadeInSplashState();
}

class _FadeInSplashState extends State<FadeInSplash> {
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
          child: AnimatedOpacity(
            opacity: widget.opacity,
            curve: widget.animationCurve!,
            onEnd: widget.onFadeInEnd,
            duration: widget.fadeInAnimationDuration!,
            child: widget.fadeInChildWidget,
          ),
        ),
      ),
    );
  }
}
