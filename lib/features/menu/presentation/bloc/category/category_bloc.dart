import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/use_case.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/usecases/get_categories_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  CategoryBloc(this._getCategoriesUseCase) : super(CategoryInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(CategoryLoading());
      final result = await _getCategoriesUseCase(NoParams());
      result.fold((l) => emit(CategoryError(message: l.message)),
          (r) => emit(CategorySuccess(categories: r)));
    });
  }
}
