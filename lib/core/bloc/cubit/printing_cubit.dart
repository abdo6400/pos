import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:printer_service/thermal_printer.dart' show PrinterDevice;
import 'package:retail/core/utils/extensions/extensions.dart';

import '../../../config/services/printing_service.dart';
import '../../entities/settings.dart';
import '../../utils/enums/printer_type_enums.dart';
import '../../utils/enums/state_enums.dart';

class PrintingCubit extends Cubit<StateEnum> {
  final PrintingService _printingService;
  PrintingCubit(this._printingService) : super(StateEnum.initial);

  Stream<List<PrinterDevice>> getPrinters(
    PrinterType printerType,
  ) {
    return _printingService.getDevices(printerType);
  }

  void handlePrint(Settings settings, BuildContext context,
      {Widget? widget, Uint8List? image, bool isTest = false}) {
    switch (settings.printerType) {
      case PrinterType.imin:
        isTest
            ? printTest(
                settings.printerType,
              )
            : print(settings.printerType, widget: widget, image: image);
        break;

      case PrinterType.bluetooth:
      case PrinterType.usb:
        final printer = settings.printerType == PrinterType.bluetooth
            ? settings.bltPrinter
            : settings.usbPrinter;

        if (printer != null) {
          isTest
              ? printTest(
                  settings.printerType,
                  printer: printer,
                )
              : print(settings.printerType,
                  widget: widget, printer: printer, image: image);
        } else {
          context.showMessageToast(msg: "Please connect to printer");
        }
        break;

      case PrinterType.network:
        if (settings.netPrinter != null ||
            (settings.printerCashIp.isNotEmpty &&
                settings.portCash.isNotEmpty)) {
          final port = int.tryParse(settings.portCash) ?? 0;
          isTest
              ? printTest(
                  settings.printerType,
                  ipAddress: settings.printerCashIp,
                  port: port,
                  printer: settings.netPrinter,
                )
              : print(
                  settings.printerType,
                  widget: widget,
                  image: image,
                  printer: settings.netPrinter,
                  ipAddress: settings.printerCashIp,
                  port: port,
                );
        } else {
          context.showMessageToast(msg: "Please enter printer ip and port");
        }
        break;
    }
  }

  Future<void> printTest(
    PrinterType printerType, {
    String ipAddress = '',
    int port = 9100,
    PrinterDevice? printer,
  }) async {
    emit(StateEnum.loading);
    Uint8List imageData = await _printingService.generateTestImage();
    bool result = await _printingService.printImage(imageData, printerType,
        ipAddress: ipAddress, port: port, printer: printer);
    if (result) {
      emit(StateEnum.success);
    } else {
      emit(StateEnum.error);
    }
  }

  Future<void> print(
    PrinterType printerType, {
    String ipAddress = '',
    int port = 9100,
    Uint8List? image,
    Widget? widget,
    PrinterDevice? printer,
  }) async {
    emit(StateEnum.loading);
    Uint8List imageData =
        widget != null ? await _printingService.generateImage(widget) : image!;
    bool result = await _printingService.printImage(imageData, printerType,
        ipAddress: ipAddress, port: port, printer: printer);
    if (result) {
      emit(StateEnum.success);
    } else {
      emit(StateEnum.error);
    }
  }

  Future<void> connectPrinter(
    PrinterType printerType,
    PrinterDevice printer, {
    String? ipAddress,
    int? port,
  }) async {
    emit(StateEnum.loading);
    if (_printingService.checkConnection(printerType)) {
      emit(StateEnum.success);
      return;
    }
    bool result = await _printingService.connect(printerType, printer,
        ipAddress: ipAddress, port: port);
    if (result) {
      emit(StateEnum.success);
    } else {
      emit(StateEnum.error);
    }
  }
}
