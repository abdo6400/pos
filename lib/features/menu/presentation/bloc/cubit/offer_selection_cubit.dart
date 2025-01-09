import 'package:bloc/bloc.dart';

class OfferSelectionCubit extends Cubit<bool> {
  OfferSelectionCubit() : super(false);

  void ShowHideOffer(bool isShow) => emit(isShow);
}
