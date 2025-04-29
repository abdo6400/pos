import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:printer_service/esc_pos_utils_platform/src/capability_profile.dart';
import 'package:printer_service/esc_pos_utils_platform/src/enums.dart';
import 'package:printer_service/esc_pos_utils_platform/src/generator.dart';
import 'package:printer_service/esc_pos_utils_platform/src/pos_styles.dart';
import 'package:printer_service/thermal_printer.dart' show PrinterDevice;
import 'package:screenshot/screenshot.dart';

import '../../core/utils/enums/printer_type_enums.dart';
import 'Imin_printer_service.dart';
import 'bluethooth_printer_service.dart';
import 'network_printer_service.dart';
import 'usb_printer_service.dart';

abstract class PrintingService {
  Future<bool> printImage(
      Uint8List imageData, PrinterType printerType, PrinterDevice? printer);
  Stream<List<PrinterDevice>> getDevices(PrinterType printerType);
  Future<bool> connect(PrinterType printerType, PrinterDevice printer);
  Future<bool> disconnect(PrinterType printerType);
  bool checkConnection(PrinterType printerType);
  Future<Uint8List> generateTestImage();
  Future<Uint8List> generateImage(Widget widget);
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
  Future<bool> connect(PrinterType printerType, PrinterDevice printer,
      {String? ipAddress, int? port}) async {
    switch (printerType) {
      case PrinterType.bluetooth:
        return await _bluetoothPrinterService.connect(printer);
      case PrinterType.usb:
        return await _usbPrinterService.connect(printer);
      case PrinterType.network:
        return await _networkPrinterService.connect(printer,
            ipAddress: ipAddress, port: port);
      case PrinterType.imin:
        return await _iminPrinterService.initSdk();
    }
  }

  @override
  Stream<List<PrinterDevice>> getDevices(PrinterType printerType) {
    switch (printerType) {
      case PrinterType.bluetooth:
        return _bluetoothPrinterService.getDevices();
      case PrinterType.usb:
        return _usbPrinterService.getDevices();
      case PrinterType.network:
        return _networkPrinterService.getDevices();
      default:
        return Stream.empty();
    }
  }

  @override
  Future<bool> printImage(
    Uint8List imageData,
    PrinterType printerType,
    PrinterDevice? printer,
  ) async {
    try {
      if (printerType != PrinterType.imin && printer == null) {
        return false;
      }
      bool isConnected = printerType == PrinterType.imin
          ? true
          : await _ensureConnection(printerType, printer!);

      if (!isConnected) return false;
      return await _delegatePrintJob(
        imageData: imageData,
        printerType: printerType,
        printer: printer,
      );
    } catch (e) {
      debugPrint('Print error: $e');
      return false;
    }
  }

  Future<bool> _ensureConnection(
      PrinterType type, PrinterDevice printer) async {
    return checkConnection(type) || await connect(type, printer);
  }

  Future<bool> _delegatePrintJob({
    required Uint8List imageData,
    required PrinterType printerType,
    PrinterDevice? printer,
  }) async {
    switch (printerType) {
      case PrinterType.bluetooth:
        return await _bluetoothPrinterService.printImage(imageData, printer!);
      case PrinterType.usb:
        return await _usbPrinterService.printImage(imageData, printer!);
      case PrinterType.network:
        return await _networkPrinterService.printImage(
          imageData,
          printer!,
        );
      case PrinterType.imin:
        return await _iminPrinterService.printImage(imageData);
    }
  }

  @override
  Future<Uint8List> generateTestImage() async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);

    final List<int> bytes = [];
    bytes.addAll(generator.text(
      "Teste Network print",
      styles: const PosStyles(
        bold: true,
        height: PosTextSize.size3,
        width: PosTextSize.size3,
      ),
    ));
    bytes.addAll(generator.cut());

    return Uint8List.fromList(bytes);
  }

  @override
  Future<bool> disconnect(PrinterType printerType) {
    switch (printerType) {
      case PrinterType.bluetooth:
        return _bluetoothPrinterService.disconnect();
      case PrinterType.usb:
        return _usbPrinterService.disconnect();
      case PrinterType.network:
        return _networkPrinterService.disconnect();
      case PrinterType.imin:
        return Future.value(true);
    }
  }

  @override
  bool checkConnection(PrinterType printerType) {
    switch (printerType) {
      case PrinterType.bluetooth:
        return _bluetoothPrinterService.checkConnection();
      case PrinterType.usb:
        return _usbPrinterService.checkConnection();
      case PrinterType.network:
        return _networkPrinterService.checkConnection();
      case PrinterType.imin:
        return true;
    }
  }

  @override
  Future<Uint8List> generateImage(Widget widget) {
    ScreenshotController screenshotController = ScreenshotController();
    return screenshotController.captureFromLongWidget(widget);
  }
}
