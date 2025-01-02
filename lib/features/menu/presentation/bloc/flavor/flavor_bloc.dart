import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/use_case.dart';
import '../../../domain/entities/flavor.dart';
import '../../../domain/usecases/get_flavors_usecase.dart';

part 'flavor_event.dart';
part 'flavor_state.dart';

class FlavorBloc extends Bloc<FlavorEvent, FlavorState> {
  final GetFlavorsUsecase _getFlavorsUsecase;
  FlavorBloc(this._getFlavorsUsecase) : super(FlavorInitial()) {
    on<GetFlavorsEvent>((event, emit) async {
      emit(FlavorLoading());
      final result = await _getFlavorsUsecase(NoParams());
      result.fold(
          (l) => emit(FlavorError(l.message)), (r) => emit(FlavorSuccess(r)));
    });
  }
}
