part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<Category> categories;
  const CategorySuccess({required this.categories});
}

class CategoryError extends CategoryState {
  final String message;
  const CategoryError({required this.message});
}
