import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FadeInSplash extends StatelessWidget {
  FadeInSplash({super.key});
  Color? backgroundColor;
  double opacity = 0;
  VoidCallback? onFadeInEnd;
  Widget? fadeInChildWidget;
  Duration? fadeInAnimationDuration;
  Curve? animationCurve = Curves.ease;
  Image? backgroundImage;
  Gradient? gradient;
  String? title;
  String? message;
  String? gifPath;
  double? gifWidth;
  double? gifHeight;
  double? titleFontSize;
  double? messageFontSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeInLeft(
                  from: 50,
                  delay: Duration(seconds: 1),
                  duration: Duration(seconds: 1),
                  child: Card(
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      width: gifWidth,
                      height: gifHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: backgroundColor,
                        image: backgroundImage != null
                            ? DecorationImage(image: backgroundImage!.image)
                            : null,
                        gradient: gradient,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: gifWidth,
                          height: gifHeight,
                          child: Image.asset(
                            gifPath!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (title != null)
                  FadeIn(
                    delay: Duration(seconds: 3),
                    duration: Duration(seconds: 2),
                    child: Text(
                      title!,
                      style: TextStyle(
                          fontSize: titleFontSize ?? 23,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
          if (message != null)
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: SlideInUp(
                delay: Duration(seconds: 3),
                duration: Duration(seconds: 2),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      bottomStart: Radius.circular(10),
                    ),
                  ),
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: message!.substring(0, message!.length ~/ 2),
                          style: TextStyle(
                            fontSize: messageFontSize ?? 20,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: message!.substring(message!.length ~/ 2),
                          style: TextStyle(
                            fontSize: messageFontSize ?? 20,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary, // Second half color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    ));
  }
}
