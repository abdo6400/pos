import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';

import '../../../config/services/printing_service.dart';
import '../../utils/enums/printer_type_enums.dart';
import '../../utils/enums/state_enums.dart';

class PrintingCubit extends Cubit<StateEnum> {
  final PrintingService _printingService;
  PrintingCubit(this._printingService) : super(StateEnum.initial);

  Stream<List<Printer>> getPrinters(
    PrinterType printerType,
  ) {
    return _printingService.getDevices(printerType);
  }

  Future<void> printTest(
    PrinterType printerType, {
    String ipAddress = '',
    int port = 9100,
    Printer? printer,
  }) async {
    emit(StateEnum.loading);
    Uint8List imageData = await _printingService.generateTestImage();
    bool result = await _printingService.printImage(imageData, printerType);
    if (result) {
      emit(StateEnum.success);
    } else {
      emit(StateEnum.error);
    }
  }

  Future<Uint8List> getImageData() async {
    return await _printingService.generateTestImage();
  }

  Future<void> connectPrinter(
    PrinterType printerType,
    Printer printer,
  ) async {
    emit(StateEnum.loading);
    bool result = await _printingService.connect(printerType, printer);
    if (result) {
      emit(StateEnum.success);
    } else {
      emit(StateEnum.error);
    }
  }
}
