import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';
import 'package:printer_service/thermal_printer.dart';

class BluetoothPrinterService {
  final PrinterManager _printerManager;

  BluetoothPrinterService({required PrinterManager printerManager})
      : _printerManager = printerManager;
  Stream<List<PrinterDevice>> getDevices() {
    try {
      return _printerManager
          .discovery(type: PrinterType.bluetooth, isBle: true)
          .scan<List<PrinterDevice>>(
        (List<PrinterDevice> accumulated, PrinterDevice device, _) {
          return [...accumulated, device]; // Add new device to the list
        },
        <PrinterDevice>[], // Initial empty list
      );
    } catch (e) {
      return Stream.empty();
    }
  }

  Future<bool> connect(PrinterDevice printer) async {
    try {
      final result = await _PrinterManagerBluetooth.connect(printer.address!);
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> printImage(Uint8List imageData, PrinterDevice printer) async {
    try {
      String path = (await getTemporaryDirectory()).path;
      final imgFile = File("$path/invoice_summary.png");
      await imgFile.writeAsBytes(imageData.buffer.asUint8List());
      await _PrinterManagerBluetooth.printImg(imgFile.path);
      return true;
    } on PlatformException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> disconnect() async {
    try {
      final result =
          await _printerManager.disconnect(type: PrinterType.bluetooth);
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkConnection(PrinterDevice printer) async {
    return await _PrinterManagerBluetooth.checkConnection(printer.address!);
  }
}

class _PrinterManagerBluetooth {
  static const platform = MethodChannel(_PrinterStrings.channel);
  static Future<bool> connect(String mac) async {
    try {
      final result = await platform.invokeMethod(
          _PrinterStrings.connectCommand, {_PrinterStrings.macArg: mac});
      return result != -1;
    } catch (e) {
      return false;
    }
  }

  static printImg(String imgPath) async {
    try {
      platform.invokeMethod(
          _PrinterStrings.printCommand, {_PrinterStrings.imgPathArg: imgPath});
    } catch (e) {}
  }

  static Future<bool> checkConnection(String mac) async {
    try {
      final result = await platform.invokeMethod(
          _PrinterStrings.checkConnection, {_PrinterStrings.macArg: mac});
      return result != -1;
    } catch (e) {
      return false;
    }
  }
}

class _PrinterStrings {
  static const String channel = 'com.futec.retail';
  static const String connectCommand = "printer_connect";
  static const String printCommand = "printer_print";
  static const String macArg = "printer_mac";
  static const String imgPathArg = "img_path";
  static const String checkConnection = "printer_check_connection";
}
