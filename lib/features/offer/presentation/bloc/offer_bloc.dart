import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  OfferBloc() : super(OfferInitial()) {
    on<OfferEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
