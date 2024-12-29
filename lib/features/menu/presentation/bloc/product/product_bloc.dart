import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:retail/core/utils/constants.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_products_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase _getProductsUsecase;
  ProductBloc(this._getProductsUsecase) : super(ProductLoading()) {
    on<GetProductsEvent>((GetProductsEvent event, emit) async {
      final branchId = (await storage.getUser())?.defaultBranch ?? "1001";
      final result = await _getProductsUsecase(branchId);
      result.fold((l) => emit(ProductError(message: l.message)),
          (r) => emit(ProductSuccess(products: r)));
    });
  }
}
