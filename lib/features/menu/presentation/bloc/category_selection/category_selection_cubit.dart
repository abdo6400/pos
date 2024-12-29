import 'package:bloc/bloc.dart';
import '../../../domain/entities/category.dart';

class CategorySelectionCubit extends Cubit<Category?> {
  CategorySelectionCubit() : super(null);

  void selectCategory(Category category) => emit(category);
}
