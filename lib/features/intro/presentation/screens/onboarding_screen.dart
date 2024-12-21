import 'package:collection/collection.dart';
import '../../../../core/utils/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/components/onboarding_component/onboarding_component.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enums/string_enums.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(bytes, filePicker: (files) {
      return files.firstWhereOrNull(
          (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontSize:
              context.ResponsiveValu(15, mobile: 12, tablet: 25, desktop: 30),
        );

    final buttonTextStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          letterSpacing: 2,
          fontSize:
              context.ResponsiveValu(15, mobile: 12, tablet: 25, desktop: 30),
        );

    final bodyTextStyle = Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.w400,
          color: Theme.of(context).hintColor,
          fontSize:
              context.ResponsiveValu(15, mobile: 10, tablet: 20, desktop: 25),
        );

    return IntroductionScreen(
      safeAreaList: [true, true, true, true],
      bodyPadding: EdgeInsets.symmetric(
        vertical:
            context.ResponsiveValu(50, mobile: 30, tablet: 60, desktop: 70),
      ),
      showSkipButton: true,
      showNextButton: false,
      dotsDecorator: DotsDecorator(
          size: Size.square(context.ResponsiveValu(
            8.0,
            mobile: 5.0,
            tablet: 15.0,
            desktop: 20.0,
          )),
          activeSize: Size.square(context.ResponsiveValu(
            12.0,
            mobile: 8.0,
            tablet: 18.0,
            desktop: 23.0,
          ))),
      curve: Curves.easeInOutCubic,
      animationDuration: 1500,
      autoScrollDuration: 4000,
      infiniteAutoScroll: true,
      skip: Text(StringEnums.skip.name.tr(), style: buttonTextStyle),
      doneStyle: ButtonStyle(
        alignment: Alignment.center,
        textStyle: WidgetStatePropertyAll(buttonTextStyle),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10),
        )),
      ),
      controlsPadding: EdgeInsets.symmetric(
          vertical: context.ResponsiveValu(
        20.0,
        mobile: 12.0,
        tablet: 15.0,
        desktop: 20.0,
      )),
      done: Text(StringEnums.get_Started.name.tr()),
      onSkip: () async => await storage.isAuthenticatedState()
          ? context.pushReplacement(AppRoutes.main)
          : context.pushReplacement(AppRoutes.login),
      onDone: () async {
        await storage.saveOnBoardingState();
        await storage.isAuthenticatedState()
            ? context.pushReplacement(AppRoutes.main)
            : context.pushReplacement(AppRoutes.login);
      },
      pages: [
        PageViewModel(
          title: StringEnums.savetime.name.tr(),
          body: StringEnums.savetime_description.name.tr(),
          image: Lottie.asset(
            Assets.savingTime,
            decoder: customDecoder,
            fit: BoxFit.fill,
          ),
          decoration: PageDecoration(
            titleTextStyle: titleTextStyle,
            bodyTextStyle: bodyTextStyle,
          ),
        ),
        PageViewModel(
          title: StringEnums.tests.name.tr(),
          body: StringEnums.tests_description.name.tr(),
          image: Lottie.asset(
            Assets.task,
            decoder: customDecoder,
            fit: BoxFit.fill,
          ),
          decoration: PageDecoration(
            titleTextStyle: titleTextStyle,
            bodyTextStyle: bodyTextStyle,
          ),
        ),
        PageViewModel(
          title: StringEnums.followup.name.tr(),
          body: StringEnums.followup_description.name.tr(),
          image: Lottie.asset(
            Assets.followup,
            decoder: customDecoder,
            fit: BoxFit.fill,
          ),
          decoration: PageDecoration(
            titleTextStyle: titleTextStyle,
            bodyTextStyle: bodyTextStyle,
          ),
        ),
      ],
    );
  }
}
