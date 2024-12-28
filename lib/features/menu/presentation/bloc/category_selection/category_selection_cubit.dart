import 'package:bloc/bloc.dart';
import '../../../domain/entities/category.dart';

class CategorySelectionCubit extends Cubit<Category> {
  CategorySelectionCubit(Category category) : super(category);

  void selectCategory(Category category) => emit(category);
}
