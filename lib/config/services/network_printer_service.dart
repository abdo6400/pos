import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' show decodeImage;
import 'package:printer_service/esc_pos_utils_platform/esc_pos_utils_platform.dart';
import 'package:printer_service/thermal_printer.dart';

class NetworkPrinterService {
   final PrinterManager _printerManager;

  NetworkPrinterService({required PrinterManager printerManager})
      : _printerManager = printerManager;
 Stream<List<PrinterDevice>> getDevices() {
    try {
      return _printerManager
          .discovery(type: PrinterType.network)
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


  Future<bool> connect(PrinterDevice printer,
      {String? ipAddress, int? port}) async {
    try {
      final bool result = await _printerManager.connect(
          type: PrinterType.network,
          model: TcpPrinterInput(
            ipAddress: ipAddress ?? printer.address!,
            port: port ?? 9100,
          ));
      return result;
    } catch (e) {
      throw Exception('Failed to connect to Bluetooth printer: $e');
    }
  }

  Future<bool> printImage(Uint8List imageData, PrinterDevice printer) async {
    try {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);
      List<int> bytes = [];
      final image = decodeImage(imageData);
      if (image != null) {
        bytes += generator.imageRaster(image);
      }
      bytes += generator.cut();
      final bool result =
          await _printerManager.send(bytes: bytes, type: PrinterType.network);
      return result;
    } on PlatformException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> disconnect() async {
    try {
      final result =
          await _printerManager.disconnect(type: PrinterType.network);
      return result;
    } catch (e) {
      return false;
    }
  }

  bool checkConnection() {
    return _printerManager.currentStatusTCP == TCPStatus.connected;
  }
}
