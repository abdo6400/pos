import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import '../enums/spinner_enum.dart';

extension OverlayLoader on BuildContext {
  Widget _getSpinner(SpinnerEnum type, {double? size}) {
    switch (type) {
      case SpinnerEnum.rotatingCircle:
        return SpinKitRotatingCircle(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.rotatingPlain:
        return SpinKitRotatingPlain(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.chasingDots:
        return SpinKitChasingDots(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.pumpingHeart:
        return SpinKitPumpingHeart(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.pulse:
        return SpinKitPulse(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.doubleBounce:
        return SpinKitDoubleBounce(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.waveStart:
        return SpinKitWave(
          color: Theme.of(this).indicatorColor,
          type: SpinKitWaveType.start,
          size: size ?? 50,
        );
      case SpinnerEnum.waveCenter:
        return SpinKitWave(
          color: Theme.of(this).indicatorColor,
          type: SpinKitWaveType.center,
          size: size ?? 50,
        );
      case SpinnerEnum.waveEnd:
        return SpinKitWave(
          color: Theme.of(this).indicatorColor,
          type: SpinKitWaveType.end,
          size: size ?? 50,
        );
      case SpinnerEnum.pianoWaveStart:
        return SpinKitPianoWave(
          color: Theme.of(this).indicatorColor,
          type: SpinKitPianoWaveType.start,
          size: size ?? 50,
        );
      case SpinnerEnum.pianoWaveCenter:
        return SpinKitPianoWave(
          color: Theme.of(this).indicatorColor,
          type: SpinKitPianoWaveType.center,
          size: size ?? 50,
        );
      case SpinnerEnum.pianoWaveEnd:
        return SpinKitPianoWave(
          color: Theme.of(this).indicatorColor,
          type: SpinKitPianoWaveType.end,
          size: size ?? 50,
        );
      case SpinnerEnum.threeBounce:
        return SpinKitThreeBounce(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.threeInOut:
        return SpinKitThreeInOut(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.wanderingCubes:
        return SpinKitWanderingCubes(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.wanderingCubesCircle:
        return SpinKitWanderingCubes(
          color: Theme.of(this).indicatorColor,
          shape: BoxShape.circle,
          size: size ?? 50,
        );
      case SpinnerEnum.circle:
        return SpinKitCircle(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.fadingFour:
        return SpinKitFadingFour(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.fadingFourRectangle:
        return SpinKitFadingFour(
          color: Theme.of(this).indicatorColor,
          shape: BoxShape.rectangle,
          size: size ?? 50,
        );
      case SpinnerEnum.fadingCube:
        return SpinKitFadingCube(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.cubeGrid:
        return SpinKitCubeGrid(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.foldingCube:
        return SpinKitFoldingCube(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.ring:
        return SpinKitRing(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.dualRing:
        return SpinKitDualRing(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.spinningLines:
        return SpinKitSpinningLines(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.fadingGrid:
        return SpinKitFadingGrid(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.fadingGridRectangle:
        return SpinKitFadingGrid(
          color: Theme.of(this).indicatorColor,
          shape: BoxShape.rectangle,
          size: size ?? 50,
        );
      case SpinnerEnum.squareCircle:
        return SpinKitSquareCircle(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.spinningCircle:
        return SpinKitSpinningCircle(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.spinningCircleRectangle:
        return SpinKitSpinningCircle(
          color: Theme.of(this).indicatorColor,
          shape: BoxShape.rectangle,
          size: size ?? 50,
        );
      case SpinnerEnum.fadingCircle:
        return SpinKitFadingCircle(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.pulsingGrid:
        return SpinKitPulsingGrid(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.pulsingGridRectangle:
        return SpinKitPulsingGrid(
          color: Theme.of(this).indicatorColor,
          boxShape: BoxShape.rectangle,
          size: size ?? 50,
        );
      case SpinnerEnum.hourGlass:
        return SpinKitHourGlass(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.pouringHourGlass:
        return SpinKitPouringHourGlass(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.pouringHourGlassRefined:
        return SpinKitPouringHourGlassRefined(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.ripple:
        return SpinKitRipple(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.dancingSquare:
        return SpinKitDancingSquare(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
      case SpinnerEnum.waveSpinner:
        return SpinKitWaveSpinner(
          color: Theme.of(this).indicatorColor,
          size: size ?? 50,
        );
    }
  }

  void showSpinKitOverlayLoader(
      {bool dismissible = false,
      SpinnerEnum? spinnerType,
      Color? barrierColor}) {
    showDialog(
        barrierDismissible: dismissible,
        context: this,
        barrierColor: barrierColor,
        useRootNavigator: dismissible,
        builder: (_) => Center(
              child: _getSpinner(spinnerType ?? SpinnerEnum.chasingDots),
            ));
  }

  void showLottieOverlayLoader(String image,
      {bool dismissible = false,
      double? height,
      double? width,
      String? text,
      TextStyle? style,
      Color? barrierColor}) {
    showDialog(
        barrierDismissible: dismissible,
        context: this,
        barrierColor: barrierColor,
        useRootNavigator: dismissible,
        builder: (_) => Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LottieBuilder.asset(
                  image,
                  height: height ?? 100,
                  width: width ?? 100,
                ),
                if (text != null)
                  Text(
                    text,
                    style: style ?? Theme.of(this).textTheme.bodyLarge,
                  )
              ],
            )));
  }

  void showCustomOverlayLoader(Widget child,
      {bool dismissible = false, Color? barrierColor}) {
    showDialog(
        barrierDismissible: dismissible,
        context: this,
        barrierColor: barrierColor,
        useRootNavigator: dismissible,
        builder: (_) => Center(child: child));
  }

  void hideOverlayLoader() {
    Navigator.pop(this, true);
  }
}
