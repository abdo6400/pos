import 'package:flutter/services.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:image/image.dart' as img;

class UsbPrinterService {
  final _flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;

  Future<List<Printer>> getDevices() async {
    try {
      await _flutterThermalPrinterPlugin.getPrinters(connectionTypes: [
        ConnectionType.USB,
      ]);

      // Get devices from stream
      final List<Printer> devices =
          await _flutterThermalPrinterPlugin.devicesStream.first;
      return devices;
    } catch (e) {
      throw Exception('Failed to get USB devices: $e');
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

  Future<String> printImage(Uint8List imageData, Printer printer) async {
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
      return 'Image printed successfully';
    } on PlatformException catch (e) {
      return 'Failed to print image: ${e.message}';
    } catch (e) {
      return 'Error printing image: $e';
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
