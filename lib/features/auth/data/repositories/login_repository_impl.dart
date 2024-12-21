import 'package:dartz/dartz.dart';
import '../../../../config/database/error/exceptions.dart';
import '../../../../config/database/error/failures.dart';
import '../../domain/entities/auth_tokens.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource _loginRempteDataSource;

  LoginRepositoryImpl({required LoginRemoteDataSource loginRempteDataSource})
      : _loginRempteDataSource = loginRempteDataSource;

  @override
  Future<Either<Failure, AuthTokens>> login(
      {required String email, required String password}) async {
    try {
      return Right(
          await _loginRempteDataSource.login(email: email, password: password));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
