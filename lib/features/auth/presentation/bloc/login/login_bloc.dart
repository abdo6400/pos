import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/auth_tokens.dart';
import '../../../domain/usecases/login_usecase.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  LoginBloc(this._loginUseCase) : super(LoginInitial()) {
    on<LoginEvent>(_onLoginEvent);
  }

  void _onLoginEvent(LoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final result = await _loginUseCase(
        LoginParams(email: event.email, password: event.password));
    result.fold((failure) => emit(LoginError(failure.message)),
        (authTokens) => emit(LoginSuccess(authTokens)));
  }
}
