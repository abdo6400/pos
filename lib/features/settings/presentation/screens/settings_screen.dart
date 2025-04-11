import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/features/settings/presentation/bloc/settings_bloc.dart';

import '../../../../core/bloc/cubit/settings_cubit.dart';
import '../../../../core/entities/settings.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/errors/error_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, Settings>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 2,
              actions: [
                IconButton(
                  onPressed: () => context.read<SettingsCubit>().saveSettings(),
                  icon: const Icon(Icons.save),
                )
              ],
              title: Text(
                StringEnums.settings.name.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: context.AppResponsiveValue(20,
                          mobile: 20, tablet: 25, desktop: 30),
                    ),
              ),
            ),
            body: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                if (state is SettingsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SettingsError) {
                  return ErrorCard(
                    message: state.message,
                    onRetry: () =>
                        context.read<SettingsBloc>().add(GetSettingsEvent()),
                  );
                } else if (state is SettingsSuccess) {
                  return ListView(children: [
                      
                    ]
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ));
      },
    );
  }
}
