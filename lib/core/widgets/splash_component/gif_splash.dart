import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GifSplash extends StatefulWidget {
  GifSplash({super.key});
  Color? backgroundColor;
  String? gifPath;
  double? gifWidth;
  double? gifHeight;
  Image? backgroundImage;
  Gradient? gradient;
  String?title;

  @override
  State<GifSplash> createState() => _GifSplashState();
}

class _GifSplashState extends State<GifSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          image: widget.backgroundImage != null
              ? DecorationImage(image: widget.backgroundImage!.image)
              : null,
          gradient: widget.gradient,
        ),
        child: Center(
          child: SizedBox(
            width: widget.gifWidth,
            height: widget.gifHeight,
            child: Image.asset(widget.gifPath!),
          ),
        ),
      ),
    );
  }
}
