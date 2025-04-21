import '../utils/enums/printer_type_enums.dart';

abstract class Settings {
  final String stationName;
  final PrinterType printerType;
  final dynamic printer;
  final String printerCashIp;
  final String portCash;
  final String printerKitchenIp1;
  final String portKitchen1;
  final String printerKitchenIp2;
  final String portKitchen2;
  final String printerKitchenIp3;
  final String portKitchen3;
  final String printerKitchenIp4;
  final String portKitchen4;

  Settings({
    required this.stationName,
    required this.printerType,
    required this.printer,
    required this.printerCashIp,
    required this.printerKitchenIp1,
    required this.printerKitchenIp2,
    required this.printerKitchenIp3,
    required this.printerKitchenIp4,
    required this.portCash,
    required this.portKitchen1,
    required this.portKitchen2,
    required this.portKitchen3,
    required this.portKitchen4,
  });

  toJson();
  Settings copyWith({
    String? stationName,
    PrinterType? printerType,
    String? printerCashIp,
    String? printerKitchenIp1,
    String? printerKitchenIp2,
    String? printerKitchenIp3,
    String? printerKitchenIp4,
    String? portCash,
    String? portKitchen1,
    String? portKitchen2,
    String? portKitchen3,
    String? portKitchen4,
    dynamic printer,
  });
}
