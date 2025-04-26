import 'dart:convert';

import 'package:printer_service/thermal_printer.dart' show PrinterDevice;

import '../entities/settings.dart';
import '../utils/enums/printer_type_enums.dart';

class SettingsModel extends Settings {
  SettingsModel({
    required super.stationName,
    required super.printerType,
    required super.printerCashIp,
    required super.printerKitchenIp1,
    required super.printerKitchenIp2,
    required super.printerKitchenIp3,
    required super.printerKitchenIp4,
    required super.portCash,
    required super.portKitchen1,
    required super.portKitchen2,
    required super.portKitchen3,
    required super.portKitchen4,
    required super.bltPrinter,
    required super.netPrinter,
    required super.usbPrinter,
    required super.addCustomAddresses,
  });

  static PrinterType _handlePrinterType(int type) {
    switch (type) {
      case 0:
        return PrinterType.imin;
      case 1:
        return PrinterType.bluetooth;
      case 2:
        return PrinterType.network;
      default:
        return PrinterType.usb;
    }
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    final btlPrinterJson =
        json['bltPrinter'] != null ? jsonDecode(json['bltPrinter']) : null;
    final netPrinterJson =
        json['netPrinter'] != null ? jsonDecode(json['netPrinter']) : null;
    final usbPrinterJson =
        json['usbPrinter'] != null ? jsonDecode(json['usbPrinter']) : null;

    return SettingsModel(
      stationName: json['stationName'] as String,
      printerType: _handlePrinterType(json['printerType'] as int),
      printerCashIp: json['printerCashIp'] as String,
      printerKitchenIp1: json['printerKitchenIp1'] as String,
      printerKitchenIp2: json['printerKitchenIp2'] as String,
      printerKitchenIp3: json['printerKitchenIp3'] as String,
      printerKitchenIp4: json['printerKitchenIp4'] as String,
      portCash: json['portCash'] as String,
      portKitchen1: json['portKitchen1'] as String,
      portKitchen2: json['portKitchen2'] as String,
      portKitchen3: json['portKitchen3'] as String,
      portKitchen4: json['portKitchen4'] as String,
      addCustomAddresses: json['addCustomAddresses'] == 1 ? true : false,
      netPrinter: netPrinterJson != null
          ? PrinterDevice(
              name: netPrinterJson['name'] as String,
              address: netPrinterJson['address'] as String?,
              productId: netPrinterJson['productId'] as String?,
              vendorId: netPrinterJson['vendorId'] as String?,
            )
          : null,
      usbPrinter: usbPrinterJson != null
          ? PrinterDevice(
              name: usbPrinterJson['name'] as String,
              address: usbPrinterJson['address'] as String?,
              productId: usbPrinterJson['productId'] as String?,
              vendorId: usbPrinterJson['vendorId'] as String?,
            )
          : null,
      bltPrinter: btlPrinterJson != null
          ? PrinterDevice(
              name: btlPrinterJson['name'] as String,
              address: btlPrinterJson['address'] as String?,
              productId: btlPrinterJson['productId'] as String?,
              vendorId: btlPrinterJson['vendorId'] as String?,
            )
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final bltPrinterJson = bltPrinter != null
        ? {
            'name': bltPrinter?.name,
            'address': bltPrinter?.address,
            'productId': bltPrinter?.productId,
            'vendorId': bltPrinter?.vendorId
          }
        : null;
    final netPrinterJson = netPrinter != null
        ? {
            'name': netPrinter?.name,
            'address': netPrinter?.address,
            'productId': netPrinter?.productId,
            'vendorId': netPrinter?.vendorId
          }
        : null;
    final usbPrinterJson = usbPrinter != null
        ? {
            'name': usbPrinter?.name,
            'address': usbPrinter?.address,
            'productId': usbPrinter?.productId,
            'vendorId': usbPrinter?.vendorId
          }
        : null;
    return {
      'stationName': stationName,
      'printerType': printerType.index,
      'printerCashIp': printerCashIp,
      'printerKitchenIp1': printerKitchenIp1,
      'printerKitchenIp2': printerKitchenIp2,
      'printerKitchenIp3': printerKitchenIp3,
      'printerKitchenIp4': printerKitchenIp4,
      'portCash': portCash,
      'addCustomAddresses': addCustomAddresses ? 1 : 0,
      'portKitchen1': portKitchen1,
      'portKitchen2': portKitchen2,
      'portKitchen3': portKitchen3,
      'portKitchen4': portKitchen4,
      'bltPrinter': bltPrinter != null ? jsonEncode(bltPrinterJson) : null,
      'netPrinter': netPrinter != null ? jsonEncode(netPrinterJson) : null,
      'usbPrinter': usbPrinter != null ? jsonEncode(usbPrinterJson) : null,
    };
  }

  SettingsModel copyWith(
      {String? stationName,
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
      bool? addCustomAddresses,
      PrinterDevice? bltPrinter,
      PrinterDevice? netPrinter,
      PrinterDevice? usbPrinter}) {
    return SettingsModel(
      stationName: stationName ?? this.stationName,
      printerType: printerType ?? this.printerType,
      printerCashIp: printerCashIp ?? this.printerCashIp,
      printerKitchenIp1: printerKitchenIp1 ?? this.printerKitchenIp1,
      printerKitchenIp2: printerKitchenIp2 ?? this.printerKitchenIp2,
      printerKitchenIp3: printerKitchenIp3 ?? this.printerKitchenIp3,
      printerKitchenIp4: printerKitchenIp4 ?? this.printerKitchenIp4,
      portCash: portCash ?? this.portCash,
      addCustomAddresses: addCustomAddresses ?? this.addCustomAddresses,
      portKitchen1: portKitchen1 ?? this.portKitchen1,
      portKitchen2: portKitchen2 ?? this.portKitchen2,
      portKitchen3: portKitchen3 ?? this.portKitchen3,
      portKitchen4: portKitchen4 ?? this.portKitchen4,
      bltPrinter: bltPrinter ?? this.bltPrinter,
      netPrinter: netPrinter ?? this.netPrinter,
      usbPrinter: usbPrinter ?? this.usbPrinter,
    );
  }
}
