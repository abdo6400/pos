import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:printer_service/thermal_printer.dart' show PrinterDevice;
import '../../entities/settings.dart';
import '../../models/settings_model.dart';
import '../../utils/enums/printer_type_enums.dart';

class SettingsCubit extends HydratedCubit<Settings> {
  SettingsCubit()
      : super(SettingsModel(
          stationName: "test",
          printerType: PrinterType.imin,
          printerCashIp: "0",
          printerKitchenIp1: "0",
          printerKitchenIp2: "0",
          printerKitchenIp3: "0",
          printerKitchenIp4: "0",
          portCash: "0",
          addCustomAddresses: false,
          portKitchen1: "0",
          portKitchen2: "0",
          portKitchen3: "0",
          portKitchen4: "0",
          bltPrinter: null,
          netPrinter: null,
          usbPrinter: null,
        ));

  void updateStationName(String stationName) {
    emit((state).copyWith(stationName: stationName));
  }

  void updatePrinterType(PrinterType printerType) {
    emit((state).copyWith(printerType: printerType));
  }

  void updatePrinterCashIp(String printerCashIp) {
    emit((state).copyWith(printerCashIp: printerCashIp));
  }

  void updatePrinterKitchenIp1(String printerKitchenIp1) {
    emit((state).copyWith(printerKitchenIp1: printerKitchenIp1));
  }

  void updatePrinterKitchenIp2(String printerKitchenIp2) {
    emit((state).copyWith(printerKitchenIp2: printerKitchenIp2));
  }

  void updatePrinterKitchenIp3(String printerKitchenIp3) {
    emit((state).copyWith(printerKitchenIp3: printerKitchenIp3));
  }

  void updatePrinterKitchenIp4(String printerKitchenIp4) {
    emit((state).copyWith(printerKitchenIp4: printerKitchenIp4));
  }

  void updatePortCash(String portCash) {
    emit((state).copyWith(portCash: portCash));
  }

  void updatePortKitchen1(String portKitchen1) {
    emit((state).copyWith(portKitchen1: portKitchen1));
  }

  void updatePortKitchen2(String portKitchen2) {
    emit((state).copyWith(portKitchen2: portKitchen2));
  }

  void updatePortKitchen3(String portKitchen3) {
    emit((state).copyWith(portKitchen3: portKitchen3));
  }

  void updatePortKitchen4(String portKitchen4) {
    emit((state).copyWith(portKitchen4: portKitchen4));
  }

  void updatePrinter(PrinterDevice printer, PrinterType printerType) {
    switch (printerType) {
      case PrinterType.bluetooth:
        emit((state).copyWith(bltPrinter: printer));
        break;
      case PrinterType.network:
        emit((state).copyWith(netPrinter: printer));
        break;
      case PrinterType.usb:
        emit((state).copyWith(usbPrinter: printer));
        break;
      case PrinterType.imin:
        break;
    }
  }

  void updateAddCustomAddresses(bool addCustomAddresses) {
    emit((state).copyWith(addCustomAddresses: addCustomAddresses));
  }

  @override
  Settings? fromJson(Map<String, dynamic> json) {
    return SettingsModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(Settings state) {
    return state.toJson();
  }
}
