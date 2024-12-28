part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final List<Product> products;
  const ProductSuccess({required this.products});
}

class ProductError extends ProductState {
  final String message;
  const ProductError({required this.message});
}
