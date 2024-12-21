import '../../../../config/database/error/failures.dart';
import '../entities/auth_tokens.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure,AuthTokens>> login({required String email, required String password});
}
