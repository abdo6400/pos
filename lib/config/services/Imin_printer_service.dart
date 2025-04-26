import 'package:flutter/services.dart';

class IminPrinterService {
  final MethodChannel _channel = const MethodChannel('com.futec.retail');

  Future<bool> initSdk() async {
    try {
      await _channel.invokeMethod('sdkInit');
      return true;
    } on PlatformException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String> getStatus() async {
    try {
      final String status = await _channel.invokeMethod('getStatus');
      return status;
    } on PlatformException catch (e) {
      return 'Failed to get printer status: ${e.message}';
    }
  }

  Future<bool> printImage(Uint8List imageData) async {
    try {
      await _channel.invokeMethod('sdkInit');
      await _channel.invokeMethod('opencashBox');
      await _channel.invokeMethod('printImage', imageData);
      return true;
    } on PlatformException {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String> getSerialNumber() async {
    try {
      final String sn = await _channel.invokeMethod('getSn');
      return sn;
    } on PlatformException catch (e) {
      return 'Failed to get serial number: ${e.message}';
    }
  }

  Future<String> openCashBox() async {
    try {
      final String result = await _channel.invokeMethod('opencashBox');
      return result;
    } on PlatformException catch (e) {
      return 'Failed to open cash box: ${e.message}';
    }
  }
}
