part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsSuccess extends SettingsState {
  final List<Setting> settings;
  const SettingsSuccess({required this.settings});
  @override
  List<Object> get props => [settings];
}

class SettingsError extends SettingsState {
  final String message;
  const SettingsError({required this.message});
  @override
  List<Object> get props => [message];
}
