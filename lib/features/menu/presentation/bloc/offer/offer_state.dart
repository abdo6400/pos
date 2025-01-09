part of 'offer_bloc.dart';

sealed class OfferState extends Equatable {
  const OfferState();

  @override
  List<Object> get props => [];
}

final class OfferInitial extends OfferState {}

final class OfferLoading extends OfferState {}

final class OfferSuccess extends OfferState {
  final List<Offer> offers;
  const OfferSuccess(this.offers);

  @override
  List<Object> get props => [offers];
}

class OfferError extends OfferState {
  final String message;
  const OfferError(this.message);

  @override
  List<Object> get props => [message];
}
