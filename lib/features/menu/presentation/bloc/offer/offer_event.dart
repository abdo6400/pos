part of 'offer_bloc.dart';

sealed class OfferEvent extends Equatable {
  const OfferEvent();

  @override
  List<Object> get props => [];
}

class GetOfferEvent extends OfferEvent {}
