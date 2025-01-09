import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/utils/constants.dart';
import '../../../domain/entities/offer.dart';
import '../../../domain/usecases/get_offers_usecase.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final GetOffersUseCase _getOffersUseCase;
  OfferBloc(this._getOffersUseCase) : super(OfferInitial()) {
    on<GetOfferEvent>((event, emit) async {
      emit(OfferLoading());
      final branchId = (await storage.getUser())?.defaultBranch ?? "1001";
      final result = await _getOffersUseCase.call(branchId);
      result.fold(
          (l) => emit(OfferError(l.message)), (r) => emit(OfferSuccess(r)));
    });
  }
}
