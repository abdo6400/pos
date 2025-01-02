part of 'flavor_bloc.dart';

sealed class FlavorState extends Equatable {
  const FlavorState();

  @override
  List<Object> get props => [];
}

final class FlavorInitial extends FlavorState {}

class FlavorLoading extends FlavorState {}

class FlavorSuccess extends FlavorState {
  final List<Flavor> flavors;
  const FlavorSuccess(this.flavors);
}

class FlavorError extends FlavorState {
  final String message;
  const FlavorError(this.message);
}
