import 'package:bloc/bloc.dart';

class BarcodeReaderCubit extends Cubit<bool> {
  BarcodeReaderCubit() : super(false);

  void setVisibility(bool value) => emit(value);
}
