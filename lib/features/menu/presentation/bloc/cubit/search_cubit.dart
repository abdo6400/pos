import 'package:bloc/bloc.dart';

class SearchCubit extends Cubit<String?> {
  SearchCubit() : super(null);

  void changeSearch(String? search) => emit(search);
}
