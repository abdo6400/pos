import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_thermal_printer/utils/printer.dart' show Printer;
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../core/bloc/cubit/printing_cubit.dart';
import '../../../../core/bloc/cubit/settings_cubit.dart';
import '../../../../core/entities/settings.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enums/printer_type_enums.dart';
import '../../../../core/utils/enums/state_enums.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/errors/error_card.dart';
import '../bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static MultiSelectController<PrinterType> controller =
      MultiSelectController();
  static GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Widget _buildPrinterType(Settings settings, BuildContext context) {
    if (settings.printerType == PrinterType.imin) {
      return Center();
    }
    if (settings.printerType == PrinterType.bluetooth ||
        settings.printerType == PrinterType.usb) {
      return Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.change_circle_outlined,
              color: Theme.of(context).primaryColor,
              size: context.AppResponsiveValue(20,
                  mobile: 20, tablet: 25, desktop: 30),
            ),
            title: Text(
              StringEnums.choose_printer.name.tr(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: context.AppResponsiveValue(18,
                        mobile: 18, tablet: 24, desktop: 30),
                  ),
            ),
            trailing: Text(
              settings.printer?.name ??
                  StringEnums.no_printer_selected.name.tr(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: context.AppResponsiveValue(18,
                        mobile: 18, tablet: 24, desktop: 30),
                  ),
            ),
          ),
          StreamBuilder<List<Printer>>(
              stream: context
                  .read<PrintingCubit>()
                  .getPrinters(settings.printerType),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MultiSelectCheckList<Printer>(
                            maxSelectableCount: 1,
                            singleSelectedItem: true,
                            listViewSettings: ListViewSettings(
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      height: 0,
                                    )),
                            onChange: (allSelectedItems, selectedItem) {
                              context
                                  .read<SettingsCubit>()
                                  .updatePrinter(selectedItem);
                              context.read<PrintingCubit>().connectPrinter(
                                  settings.printerType, selectedItem);
                            },
                            items: List.generate(
                                snapshot.data!.length,
                                (index) => CheckListCard(
                                      value: snapshot.data![index],
                                      selected: snapshot.data![index].address
                                              ?.compareTo(
                                                  settings.printer?.address ??
                                                      "") ==
                                          0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      title: Text(
                                        snapshot.data![index].name ?? "",
                                      ),
                                      subtitle: Text(
                                        snapshot.data![index].address ?? "",
                                      ),
                                      leadingCheckBox: false,
                                    ))),
                      )
                    : CircularProgressIndicator();
              })
        ],
      );
    }

    Widget _buildPrinterInputRow({
      required String ipLabel,
      required String portLabel,
      required String ipValue,
      required String portValue,
      required Function(String) onIpChanged,
      required Function(String) onPortChanged,
    }) {
      return Row(
        spacing: 20,
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: onIpChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: Icon(Icons.network_wifi),
                    labelText: ipLabel.tr(),
                    hintText: ipValue.toString(),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: onPortChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    prefixIcon: Icon(Icons.format_list_numbered),
                    labelText: portLabel.tr(),
                    hintText: portValue.toString(),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      spacing: 20,
      children: [
        _buildPrinterInputRow(
          ipLabel: StringEnums.printer_cash_ip.name,
          portLabel: StringEnums.printer_cash_port.name,
          ipValue: settings.printerCashIp,
          portValue: settings.portCash,
          onIpChanged: (value) =>
              context.read<SettingsCubit>().updatePrinterCashIp(value),
          onPortChanged: (value) =>
              context.read<SettingsCubit>().updatePortCash(value),
        ),
        _buildPrinterInputRow(
          ipLabel: StringEnums.printer_kitchen_ip1.name,
          portLabel: StringEnums.printer_kitchen_port1.name,
          ipValue: settings.printerKitchenIp1,
          portValue: settings.portKitchen1,
          onIpChanged: (value) =>
              context.read<SettingsCubit>().updatePrinterKitchenIp1(value),
          onPortChanged: (value) =>
              context.read<SettingsCubit>().updatePortKitchen1(value),
        ),
        _buildPrinterInputRow(
          ipLabel: StringEnums.printer_kitchen_ip2.name,
          portLabel: StringEnums.printer_kitchen_port2.name,
          ipValue: settings.printerKitchenIp2,
          portValue: settings.portKitchen2,
          onIpChanged: (value) =>
              context.read<SettingsCubit>().updatePrinterKitchenIp2(value),
          onPortChanged: (value) =>
              context.read<SettingsCubit>().updatePortKitchen2(value),
        ),
        _buildPrinterInputRow(
          ipLabel: StringEnums.printer_kitchen_ip3.name,
          portLabel: StringEnums.printer_kitchen_port3.name,
          ipValue: settings.printerKitchenIp3,
          portValue: settings.portKitchen3,
          onIpChanged: (value) =>
              context.read<SettingsCubit>().updatePrinterKitchenIp3(value),
          onPortChanged: (value) =>
              context.read<SettingsCubit>().updatePortKitchen3(value),
        ),
        _buildPrinterInputRow(
          ipLabel: StringEnums.printer_kitchen_ip4.name,
          portLabel: StringEnums.printer_kitchen_port4.name,
          ipValue: settings.printerKitchenIp4,
          portValue: settings.portKitchen4,
          onIpChanged: (value) =>
              context.read<SettingsCubit>().updatePrinterKitchenIp4(value),
          onPortChanged: (value) =>
              context.read<SettingsCubit>().updatePortKitchen4(value),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: context.AppResponsiveValue(18,
              mobile: 18, tablet: 20, desktop: 25),
        );
    return BlocConsumer<PrintingCubit, StateEnum>(
      listener: (context, state) {
        if (state == StateEnum.loading) {
          context.showLottieOverlayLoader(Assets.loader);
        } else if (state == StateEnum.success) {
          context.handleState(state, "");
        } else if (state == StateEnum.error) {
          context.handleState(state, "");
        }
      },
      builder: (context, state) {
        return BlocBuilder<SettingsCubit, Settings>(
          builder: (context, settings) {
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
                floatingActionButton: ElevatedButton(
                  
                  onPressed: () {
                    if (settings.printerType == PrinterType.imin) {
                      context.read<PrintingCubit>().printTest(
                            settings.printerType,
                            printer: settings.printer,
                            ipAddress: settings.printerCashIp,
                            port: int.parse(settings.portCash),
                          );
                    } else if (settings.printerType == PrinterType.bluetooth ||
                        settings.printerType == PrinterType.usb) {
                      if (settings.printer != null &&
                          (settings.printer!.isConnected ?? false)) {
                        context.read<PrintingCubit>().printTest(
                              settings.printerType,
                              printer: settings.printer,
                              ipAddress: settings.printerCashIp,
                              port: int.parse(settings.portCash),
                            );
                      } else {
                        context.showMessageToast(
                            msg: "Please connect to printer");
                      }
                    } else if (settings.printerType == PrinterType.network) {
                      if (settings.printerCashIp.isNotEmpty &&
                          settings.portCash.isNotEmpty) {
                        context.read<PrintingCubit>().printTest(
                              settings.printerType,
                              printer: settings.printer,
                              ipAddress: settings.printerCashIp,
                              port: int.parse(settings.portCash),
                            );
                      } else {
                        context.showMessageToast(
                            msg: "Please enter printer ip and port");
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20,
                    children: [
                      Icon(Icons.print_rounded),
                      Text(StringEnums.test_print.name.tr()),
                    ],
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
                        onRetry: () => context
                            .read<SettingsBloc>()
                            .add(GetSettingsEvent()),
                      );
                    } else if (state is SettingsSuccess) {
                      return ListView(
                          padding: EdgeInsets.all(context.AppResponsiveValue(10,
                              mobile: 10, tablet: 15, desktop: 20)),
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.print,
                                  color: Theme.of(context).primaryColor,
                                  size: context.AppResponsiveValue(20,
                                      mobile: 20, tablet: 25, desktop: 30),
                                ),
                                Text(
                                  StringEnums.printer_type.name.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: context.AppResponsiveValue(18,
                                            mobile: 18,
                                            tablet: 24,
                                            desktop: 25),
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.AppResponsiveValue(10,
                                  mobile: 10, tablet: 15, desktop: 20),
                            ),
                            Card(
                              child: MultiSelectCheckList<PrinterType>(
                                maxSelectableCount: 1,
                                singleSelectedItem: true,
                                listViewSettings: ListViewSettings(
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                          height: 0,
                                        )),
                                controller: controller,
                                items: List.generate(
                                    PrinterType.values.length,
                                    (index) => CheckListCard(
                                          value: PrinterType.values[index],
                                          selected: settings
                                                  .printerType.index ==
                                              PrinterType.values[index].index,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          title: Text(
                                            PrinterType.values[index].name.tr(),
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
                              ),
                            ),
                            SizedBox(
                              height: context.AppResponsiveValue(10,
                                  mobile: 10, tablet: 15, desktop: 20),
                            ),
                            _buildPrinterType(settings, context)
                          ]);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ));
          },
        );
      },
    );
  }
}
