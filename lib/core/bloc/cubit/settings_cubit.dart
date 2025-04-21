import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../entities/settings.dart';
import '../../models/settings_model.dart';
import '../../utils/enums/printer_type_enums.dart';

class SettingsCubit extends HydratedCubit<Settings> {
  SettingsCubit()
      : super(SettingsModel(
          stationName: "",
          printerType: PrinterType.imin,
          printerCashIp: "",
          printerKitchenIp1: "",
          printerKitchenIp2: "",
          printerKitchenIp3: "",
          printerKitchenIp4: "",
          portCash: "",
          portKitchen1: "",
          portKitchen2: "",
          portKitchen3: "",
          portKitchen4: "",
          vendorId: "",
          productId: "",
          macAddress: "",
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
    emit((state)
        .copyWith(printerKitchenIp1: printerKitchenIp1));
  }

  void updatePrinterKitchenIp2(String printerKitchenIp2) {
    emit((state)
        .copyWith(printerKitchenIp2: printerKitchenIp2));
  }

  void updatePrinterKitchenIp3(String printerKitchenIp3) {
    emit((state)
        .copyWith(printerKitchenIp3: printerKitchenIp3));
  }

  void updatePrinterKitchenIp4(String printerKitchenIp4) {
    emit((state)
        .copyWith(printerKitchenIp4: printerKitchenIp4));
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

  void updateVendorId(String vendorId) {
    emit((state).copyWith(vendorId: vendorId));
  }

  void updateProductId(String productId) {
    emit((state).copyWith(productId: productId));
  }

  void updateMacAddress(String macAddress) {
    emit((state).copyWith(macAddress: macAddress));
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
