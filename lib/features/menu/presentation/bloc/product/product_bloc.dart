import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_products_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase _getProductsUsecase;
  ProductBloc(this._getProductsUsecase) : super(ProductLoading()) {
    on<GetProductsEvent>((GetProductsEvent event, emit) async {
      final result = await _getProductsUsecase(event.branchId);
      result.fold((l) => emit(ProductError(message: l.message)),
          (r) => emit(ProductSuccess(products: r)));
    });
  }
}
