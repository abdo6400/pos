import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/constants.dart';
import '../../domain/entities/setting.dart';
import '../../domain/usecases/get_settings_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUsecase _getSettingsUsecase;

  SettingsBloc(this._getSettingsUsecase) : super(SettingsInitial()) {
    on<GetSettingsEvent>((event, emit) async {
      emit(SettingsLoading());
      final branchId = (await storage.getUser())?.defaultBranch ?? "1001";
      final result = await _getSettingsUsecase(branchId);
      result.fold((l) => emit(SettingsError(message: l.message)),
          (r) => emit(SettingsSuccess(settings: r)));
    });
  }
}
