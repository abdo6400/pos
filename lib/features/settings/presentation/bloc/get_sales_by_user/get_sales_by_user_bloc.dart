import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/entities/cash.dart';
import '../../../domain/usecases/get_sales_by_user_usecase.dart';

part 'get_sales_by_user_event.dart';
part 'get_sales_by_user_state.dart';

class GetSalesByUserBloc
    extends Bloc<GetSalesByUserEvent, GetSalesByUserState> {
  final GetSalesByUserUsecase _getSalesByUserUsecase;

  GetSalesByUserBloc(this._getSalesByUserUsecase)
      : super(GetSalesByUserInitial()) {
    on<GetSalesByUserRequested>((event, emit) async {
      emit(GetSalesByUserLoading());
      final result = await _getSalesByUserUsecase(event.userId);
      result.fold(
        (failure) => emit(GetSalesByUserFailure(message: failure.message)),
        (cash) => emit(GetSalesByUserSuccess(cash: cash)),
      );
    });
  }
}
