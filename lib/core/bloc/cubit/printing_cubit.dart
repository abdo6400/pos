import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:printer_service/thermal_printer.dart' show PrinterDevice;
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../config/services/printing_service.dart';
import '../../entities/settings.dart';
import '../../utils/enums/printer_type_enums.dart';
import '../../utils/enums/printing_status_enums.dart';

class PrintingCubit extends Cubit<PrintingStatusEnums> {
  final PrintingService _printingService;
  PrintingCubit(this._printingService) : super(PrintingStatusEnums.none);

  Stream<List<PrinterDevice>> getPrinters(
    PrinterType printerType,
  ) {
    return _printingService.getDevices(printerType);
  }

  void handlePrint(
    Settings settings,
    BuildContext context, {
    Widget? widget,
    Uint8List? image,
    bool isTest = false,
    Function? onPrint,
  }) {
    switch (settings.printerType) {
      case PrinterType.imin:
        isTest
            ? printTest(
                settings.printerType,
              )
            : print(settings.printerType,
                widget: widget, image: image, onPrint: onPrint);
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
                  widget: widget,
                  printer: printer,
                  image: image,
                  onPrint: onPrint);
        } else {
          context.showMessageToast(msg: "Please connect to printer");
        }
        break;

      case PrinterType.network:
        final printer = settings.netPrinter;
        if (printer != null) {
          isTest
              ? printTest(
                  settings.printerType,
                  printer: printer,
                )
              : print(settings.printerType,
                  widget: widget,
                  image: image,
                  printer: printer,
                  onPrint: onPrint);
        } else {
          context.showMessageToast(msg: "Please enter printer ip and port");
        }
        break;
    }
  }

  Future<void> printTest(
    PrinterType printerType, {
    PrinterDevice? printer,
  }) async {
    emit(PrintingStatusEnums.printing);
    Uint8List imageData = await _printingService.generateTestImage();
    bool result =
        await _printingService.printImage(imageData, printerType, printer);
    if (result) {
      emit(PrintingStatusEnums.printed);
    } else {
      emit(PrintingStatusEnums.error);
    }
  }

  Future<void> print(
    PrinterType printerType, {
    Uint8List? image,
    Widget? widget,
    PrinterDevice? printer,
    Function? onPrint,
  }) async {
    emit(PrintingStatusEnums.printing);
    Uint8List imageData =
        widget != null ? await _printingService.generateImage(widget) : image!;
    bool result =
        await _printingService.printImage(imageData, printerType, printer);
    if (result) {
      emit(PrintingStatusEnums.printed);
    } else {
      emit(PrintingStatusEnums.error);
    }
    onPrint?.call();
  }

  Future<void> connectPrinter(
      PrinterType printerType, PrinterDevice printer) async {
    emit(PrintingStatusEnums.connecting);
    if (await _printingService.checkConnection(printerType, printer)) {
      emit(PrintingStatusEnums.connected);
      return;
    }
    bool result = await _printingService.connect(
      printerType,
      printer,
    );
    debugPrint("connectmm" + result.toString());
    if (result) {
      emit(PrintingStatusEnums.connected);
    } else {
      emit(PrintingStatusEnums.error);
    }
  }
}
