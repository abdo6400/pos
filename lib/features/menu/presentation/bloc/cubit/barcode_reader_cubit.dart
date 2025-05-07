import 'package:bloc/bloc.dart';

class BarcodeReaderCubit extends Cubit<String?> {
  BarcodeReaderCubit() : super(null);

  void setVisibility(String? value) => emit(value);
}
