import '../../core/utils/constants.dart';
import '../../features/auth/data/datasources/login_remote_data_source.dart';
import '../../features/auth/data/repositories/login_repository_impl.dart';
import '../../features/auth/domain/repositories/login_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/bloc/login/login_bloc.dart';

class AuthLocator {
  static Future<void> init() async {
    //login
    locator.registerLazySingleton<LoginBloc>(() => LoginBloc(locator()));
    locator.registerLazySingleton<LoginUseCase>(() => LoginUseCase(locator()));
    locator.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(loginRempteDataSource: locator()));
    locator.registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSourceImpl(apiConsumer: locator()));
    //register

    //forget-password
  }
}

