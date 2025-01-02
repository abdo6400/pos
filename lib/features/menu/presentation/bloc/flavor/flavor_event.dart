part of 'flavor_bloc.dart';

sealed class FlavorEvent extends Equatable {
  const FlavorEvent();

  @override
  List<Object> get props => [];
}

class GetFlavorsEvent extends FlavorEvent {}
