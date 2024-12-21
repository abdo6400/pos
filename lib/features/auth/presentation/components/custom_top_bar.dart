import 'package:animate_do/animate_do.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomTopBar extends StatelessWidget {
  final String title;
  final String image;
  final String? message;

  const CustomTopBar({
    super.key,
    required this.title,
    required this.image,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ))),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: FadeInRight(
            child: Text(
              title.tr(),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: context.ResponsiveValu(16,
                        mobile: 14, tablet: 20, desktop: 24),
                  ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: AlignmentDirectional.center,
            child: FadeInLeft(
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(
                  image,
                ),
              ),
            ),
          ),
        ),
        if (message != null)
          Container(
            alignment: AlignmentDirectional.centerEnd,
            padding: EdgeInsetsDirectional.only(
              end: context.ResponsiveValu(20,
                  mobile: 15, tablet: 24, desktop: 30),
            ),
            child: FadeInRight(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: message!.tr().substring(0, 5),
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: context.ResponsiveValu(16,
                                    mobile: 14, tablet: 20, desktop: 24),
                              ),
                    ),
                    TextSpan(
                      text: message!.tr().substring(5),
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: context.ResponsiveValu(16,
                                    mobile: 14, tablet: 20, desktop: 24),
                              ),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          )
      ],
    );
  }
}
