import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/auth_tokens.dart';
import '../repositories/login_repository.dart';

class LoginUseCase extends UseCase<Either<Failure, AuthTokens>, LoginParams> {
  final LoginRepository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, AuthTokens>> call(LoginParams params)  {
    return  _repository.login(
        email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});
}
