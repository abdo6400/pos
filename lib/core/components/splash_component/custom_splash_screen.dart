import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/enums/splash_type_enum.dart';
import 'fade_in_splash.dart';
import 'gif_splash.dart';
import 'lottie_splash.dart';
import 'scale_splash.dart';

typedef AsyncCallback = Future Function();

// ignore: must_be_immutable
class CustomSplashScreen extends StatefulWidget {
  CustomSplashScreen({
    Key? key,
    this.duration,
    this.backgroundColor,
    this.splashScreenBody,
    this.nextScreen,
    this.setStateTimer = const Duration(milliseconds: 100),
    this.setStateCallback,
    this.onInit,
    this.onEnd,
    this.asyncNavigationCallback,
    this.useImmersiveMode = false,
  }) : super(key: key);

  String? title;
  String? message;
  double? titleFontSize;
  double? messageFontSize;
  Duration? duration;
  Color? backgroundColor;
  Widget? splashScreenBody;
  Widget? nextScreen;
  AsyncCallback? asyncNavigationCallback;
  Duration setStateTimer;
  VoidCallback? setStateCallback;
  VoidCallback? onInit;
  VoidCallback? onEnd;
  String? gifPath;
  double? gifWidth;
  double? gifHeight;
  double _opacity = 0;
  double _scale = 0;
  VoidCallback? onAnimationEnd;
  Widget? childWidget;
  Duration? animationDuration;
  SplashType splashType = SplashType.custom;
  Curve animationCurve = Curves.ease;
  Image? backgroundImage;
  Gradient? gradient;
  bool useImmersiveMode;

  CustomSplashScreen.gif({
    super.key,
    required this.gifPath,
    required this.gifWidth,
    required this.gifHeight,
    this.nextScreen,
    this.duration,
    this.title,this.message,
    this.backgroundColor,
    this.setStateTimer = const Duration(milliseconds: 100),
    this.setStateCallback,
    this.onInit,
    this.onEnd,
    this.asyncNavigationCallback,
    this.backgroundImage,
    this.gradient,
    this.useImmersiveMode = false,
  }) {
    splashType = SplashType.gif;
  }
  CustomSplashScreen.lottie({
    super.key,
    required this.gifPath,
    required this.gifWidth,
    required this.gifHeight,
    this.nextScreen,
    this.duration,
    this.backgroundColor,
    this.setStateTimer = const Duration(milliseconds: 100),
    this.setStateCallback,
    this.onInit,
    this.onEnd,
    this.title,
    this.message,
    this.asyncNavigationCallback,
    this.backgroundImage,
    this.gradient,
    this.titleFontSize,
    this.messageFontSize,
    this.useImmersiveMode = false,
  }) {
    splashType = SplashType.lottie;
  }

  CustomSplashScreen.fadeIn({
    super.key,
    this.nextScreen,
    required this.childWidget,
    this.animationCurve = Curves.ease,
    this.animationDuration = const Duration(milliseconds: 2000),
    this.duration,
    this.backgroundColor,
    this.setStateTimer = const Duration(milliseconds: 200),
    this.onAnimationEnd,
    this.onInit,
    this.onEnd,
    this.title,this.message,
    this.asyncNavigationCallback,
    this.backgroundImage,
    this.gradient,
    this.useImmersiveMode = false,
  }) {
    splashType = SplashType.fadeIn;
    setStateCallback = () {
      _opacity = 1;
    };
  }

  CustomSplashScreen.scale({
    super.key,
    this.nextScreen,
    required this.childWidget,
    this.animationCurve = Curves.ease,
    this.animationDuration = const Duration(milliseconds: 2000),
    this.duration,
    this.backgroundColor,
    this.setStateTimer = const Duration(milliseconds: 200),
    this.onAnimationEnd,
    this.onInit,
    this.onEnd,
    this.title,this.message,
    this.asyncNavigationCallback,
    this.backgroundImage,
    this.gradient,
    this.useImmersiveMode = false,
  }) {
    splashType = SplashType.scale;
    setStateCallback = () {
      _scale = 1;
    };
  }

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.useImmersiveMode) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    }
    widget.onInit?.call();
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    Future.delayed(widget.setStateTimer, () {
      if (mounted) {
        widget.setStateCallback?.call();
        setState(() {});
      }
    });

    if (widget.asyncNavigationCallback != null) {
      assert(widget.duration == null);
      await widget.asyncNavigationCallback?.call();
    } else {
      widget.duration ??= const Duration(seconds: 2);
    }

    Future.delayed(widget.duration ?? const Duration(), () {
      widget.onEnd?.call();
      if (widget.nextScreen == null) {
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return widget.nextScreen ?? Container();
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.useImmersiveMode) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.splashType == SplashType.gif) {
      return GifSplash()
        ..backgroundColor = widget.backgroundColor
        ..gifPath = widget.gifPath
        ..gifHeight = widget.gifHeight
        ..gifWidth = widget.gifWidth
        ..backgroundImage = widget.backgroundImage
        ..title = widget.title  
        ..gradient = widget.gradient;
    } else if (widget.splashType == SplashType.fadeIn) {
      return FadeInSplash()
        ..opacity = widget._opacity
        ..backgroundColor = widget.backgroundColor
        ..onFadeInEnd = widget.onAnimationEnd
        ..fadeInChildWidget = widget.childWidget
        ..fadeInAnimationDuration = widget.animationDuration
        ..animationCurve = widget.animationCurve
        ..backgroundImage = widget.backgroundImage
        ..title = widget.title 
        ..gradient = widget.gradient;
    } else if (widget.splashType == SplashType.scale) {
      return ScaleSplash()
        ..scale = widget._scale
        ..backgroundColor = widget.backgroundColor
        ..onScaleEnd = widget.onAnimationEnd
        ..scaleChildWidget = widget.childWidget
        ..scaleAnimationDuration = widget.animationDuration
        ..animationCurve = widget.animationCurve
        ..backgroundImage = widget.backgroundImage
        ..title = widget.title 
        ..gradient = widget.gradient;
    } else if (widget.splashType == SplashType.lottie) {
      return LottieSplash()
        ..backgroundColor = widget.backgroundColor
        ..gifPath = widget.gifPath
        ..gifHeight = widget.gifHeight
        ..gifWidth = widget.gifWidth
        ..backgroundImage = widget.backgroundImage
        ..title = widget.title 
        ..message = widget.message
        ..titleFontSize = widget.titleFontSize
        ..messageFontSize = widget.messageFontSize
        ..gradient = widget.gradient;
    } else {
      return Scaffold(
        backgroundColor:
            widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
        body: widget.splashScreenBody,
      );
    }
  }
}
