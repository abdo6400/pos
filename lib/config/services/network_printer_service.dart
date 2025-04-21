import 'package:flutter/services.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:image/image.dart' show decodeImage;

class NetworkPrinterService {
  Future<String> printImage(
      Uint8List imageData, String ipAddress, int port) async {
    try {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);
      List<int> bytes = [];
      final image = decodeImage(imageData);
      if (image != null) {
        bytes += generator.image(image);
      }
      bytes += generator.cut();
      final service = FlutterThermalPrinterNetwork(ipAddress, port: port);
      await service.connect();
      await service.printTicket(bytes);
      await service.disconnect();
      return 'Image printed successfully';
    } on PlatformException catch (e) {
      return 'Failed to print image: ${e.message}';
    } catch (e) {
      return 'Error printing image: $e';
    }
  }
}
