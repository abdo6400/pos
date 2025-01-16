import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/bloc/cubit/user_cubit.dart';
import '../../../../../core/widgets/lang_theme_options.dart';
import 'info_popup.dart';
import 'search_bar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
      child: Row(
        spacing: 10,
        children: [
          Expanded(flex: 8, child: SearchAppBar()),
          Spacer(
            flex: 2,
          ),
          Row(children: [
            InfoPopup(
              cubit: context.read<UserCubit>(),
            ),
            LangThemeOptions(),
          ])
        ],
      ),
    );
  }
}
