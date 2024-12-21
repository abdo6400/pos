import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class LottieSplash extends StatelessWidget {
  LottieSplash({super.key});
  Color? backgroundColor;
  String? gifPath;
  double? gifWidth;
  double? gifHeight;
  Image? backgroundImage;
  Gradient? gradient;
  String? title;
  String? message;
  double? titleFontSize;
  double? messageFontSize;

  AnimationController? animateController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SlideInUp(
                  from: 50,
                  delay: Duration(seconds: 3),
                  duration: Duration(seconds: 2),
                  child: Container(
                    decoration: BoxDecoration(
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
                        child: Lottie.asset(
                          gifPath!,
                          onLoaded: (p0) {},
                          fit: BoxFit.fill,
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
    );
  }
}
