import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:printer_service/thermal_printer.dart' show PrinterDevice;

import '../../../config/services/printing_service.dart';
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

  Future<Uint8List> getImageData() async {
    return await _printingService.generateTestImage();
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
