import 'package:flutter/services.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';

class UsbPrinterService {
  final _flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;

  Stream<List<Printer>> getDevices() {
    try {
      _flutterThermalPrinterPlugin.getPrinters(connectionTypes: [
        ConnectionType.USB,
      ]);
      return _flutterThermalPrinterPlugin.devicesStream;
    } catch (e) {
      return Stream.empty();
    }
  }

  Future<bool> connect(Printer printer) async {
    try {
      if (printer.isConnected ?? false) {
        return true;
      }

      final bool result = await _flutterThermalPrinterPlugin.connect(printer);
      return result;
    } catch (e) {
      throw Exception('Failed to connect to USB printer: $e');
    }
  }

  Future<bool> printImage(Uint8List imageData, Printer printer) async {
    try {
      // final profile = await CapabilityProfile.load();
      // final generator = Generator(PaperSize.mm80, profile);
      // List<int> bytes = [];
      // final image = img.decodeImage(imageData);
      // if (image != null) {
      //   bytes += generator.image(image);
      // }
      // bytes += generator.cut();

      await _flutterThermalPrinterPlugin.printImageBytes(
          imageBytes: imageData, printer: printer);
       return true;
    } on PlatformException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> disconnect(Printer printer) async {
    try {
      await _flutterThermalPrinterPlugin.disconnect(printer);
      return true;
    } catch (e) {
      return false;
    }
  }
}
