import 'package:bloc/bloc.dart';

import '../../../config/services/printing_service.dart';

class PrintingCubit extends Cubit<bool> {
  final PrintingService _printingService;
  PrintingCubit(this._printingService) : super(false);
}
