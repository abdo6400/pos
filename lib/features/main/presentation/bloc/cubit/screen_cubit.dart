import 'package:bloc/bloc.dart';

class ScreenCubit extends Cubit<int> {
  ScreenCubit() : super(0);

  void changeScreen(int index) => emit(index);
}
