import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/discount.dart';
import '../../../domain/usecases/get_discounts_usecase.dart';

part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final GetDiscountsUsecase _getDiscountsUsecase;
  DiscountBloc(this._getDiscountsUsecase) : super(DiscountInitial()) {
    on<GetDiscountEvent>((event, emit) async {
      emit(DiscountLoading());
      final branchId = (await storage.getUser())?.defaultBranch ?? "1001";
      final result = await _getDiscountsUsecase(branchId);
      result.fold((l) => emit(DiscountError(l.message)),
          (r) => emit(DiscountSuccess(r)));
    });
  }
}
