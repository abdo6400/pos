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

  List<Product> filteredProductsByCategory(String catId) {
    try {
      return products.where((x) => catId.compareTo(x.catId) == 0).toList();
    } catch (e) {
      return [];
    }
  }

  List<Product> filteredProductsByName(String? name) {
    try {
      if (name == null) return products;
      return products
          .where((x) =>
              x.proArName
                  .toString()
                  .toLowerCase()
                  .contains(name.toLowerCase()) ||
              x.proEnName.toString().toLowerCase().contains(name.toLowerCase()))
          .toList();
    } catch (e) {
      return [];
    }
  }
}

class ProductError extends ProductState {
  final String message;
  const ProductError({required this.message});
}
