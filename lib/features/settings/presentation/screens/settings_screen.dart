import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/features/settings/presentation/bloc/settings_bloc.dart';

import '../../../../core/bloc/cubit/settings_cubit.dart';
import '../../../../core/entities/settings.dart';
import '../../../../core/utils/enums/printer_type_enums.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/errors/error_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static MultiSelectController<PrinterType> controller =
      MultiSelectController();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: context.AppResponsiveValue(18,
              mobile: 18, tablet: 20, desktop: 25),
        );
    return BlocBuilder<SettingsCubit, Settings>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 2,
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
                    MultiSelectCheckList<PrinterType>(
                      maxSelectableCount: 1,
                      listViewSettings: ListViewSettings(
                          separatorBuilder: (context, index) => const Divider(
                                height: 0,
                              )),
                      controller: controller,
                      items: List.generate(
                          PrinterType.values.length,
                          (index) => CheckListCard(
                                value: PrinterType.values[index],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                title: Text(
                                  PrinterType.values[index].name,
                                ),
                                leadingCheckBox: false,
                                textStyles: MultiSelectItemTextStyles(
                                    selectedTextStyle: style,
                                    disabledTextStyle: style,
                                    textStyle: style),
                              )),
                      onChange: (allSelectedItems, selectedItem) {
                        context
                            .read<SettingsCubit>()
                            .updatePrinterType(selectedItem);
                      },
                    )
                  ]);
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
