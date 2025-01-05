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

  List<Flavor> filteredFlavorsByCategory(String catId) {
    try {
      return flavors.where((x) => x.category.any((x) => x == catId)).toList();
    } catch (e) {
      return [];
    }
  }
}

class FlavorError extends FlavorState {
  final String message;
  const FlavorError(this.message);
}
