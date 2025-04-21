import 'dart:typed_data';

import 'package:flutter_thermal_printer/utils/printer.dart';

import '../../core/utils/enums/printer_type_enums.dart';
import 'Imin_printer_service.dart';
import 'bluethooth_printer_service.dart';
import 'network_printer_service.dart';
import 'usb_printer_service.dart';

abstract class PrintingService {
  Future<String> printImage(Uint8List imageData, PrinterType printerType,
      {String ipAddress = '', int port = 9100, Printer? printer});
  Future<List> getDevices(PrinterType printerType);
  Future<bool> connect(PrinterType printerType, Printer printer);
}

class PrintingServiceImpl implements PrintingService {
  final IminPrinterService _iminPrinterService;
  final BluetoothPrinterService _bluetoothPrinterService;
  final NetworkPrinterService _networkPrinterService;
  final UsbPrinterService _usbPrinterService;

  PrintingServiceImpl(
      {required IminPrinterService iminPrinterService,
      required BluetoothPrinterService bluetoothPrinterService,
      required NetworkPrinterService networkPrinterService,
      required UsbPrinterService usbPrinterService})
      : _iminPrinterService = iminPrinterService,
        _bluetoothPrinterService = bluetoothPrinterService,
        _networkPrinterService = networkPrinterService,
        _usbPrinterService = usbPrinterService;

  @override
  Future<bool> connect(PrinterType printerType, Printer printer) async {
    switch (printerType) {
      case PrinterType.bluetooth:
        return await _bluetoothPrinterService.connect(printer);
      case PrinterType.usb:
        return await _usbPrinterService.connect(printer);
      case PrinterType.network:
        return true;
      case PrinterType.imin:
        return await _iminPrinterService.initSdk();
    }
  }

  @override
  Future<List> getDevices(PrinterType printerType) async {
    switch (printerType) {
      case PrinterType.bluetooth:
        return await _bluetoothPrinterService.getDevices();
      case PrinterType.usb:
        return await _usbPrinterService.getDevices();
      default:
        return [];
    }
  }

  @override
  Future<String> printImage(
    Uint8List imageData,
    PrinterType printerType, {
    String ipAddress = '',
    int port = 9100,
    Printer? printer,
  }) async {
    switch (printerType) {
      case PrinterType.bluetooth:
        return await _bluetoothPrinterService.printImage(imageData, printer!);
      case PrinterType.usb:
        return await _usbPrinterService.printImage(imageData, printer!);
      case PrinterType.network:
        return await _networkPrinterService.printImage(
            imageData, ipAddress, port);
      case PrinterType.imin:
        return await _iminPrinterService.printImage(imageData);
    }
  }
}
