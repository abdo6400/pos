import '../../core/utils/constants.dart';
import '../../features/menu/data/datasources/menu_local_data_source.dart';
import '../../features/menu/data/datasources/menu_remote_data_source.dart';
import '../../features/menu/data/repositories/menu_repository_impl.dart';
import '../../features/menu/domain/repositories/menu_repository.dart';
import '../../features/menu/domain/usecases/get_categories_usecase.dart';
import '../../features/menu/domain/usecases/get_discounts_usecase.dart';
import '../../features/menu/domain/usecases/get_flavors_usecase.dart';
import '../../features/menu/domain/usecases/get_products_usecase.dart';
import '../../features/menu/domain/usecases/get_questions_usecase.dart';
import '../../features/menu/presentation/bloc/category/category_bloc.dart';
import '../../features/menu/presentation/bloc/discount/discount_bloc.dart';
import '../../features/menu/presentation/bloc/flavor/flavor_bloc.dart';
import '../../features/menu/presentation/bloc/product/product_bloc.dart';
import '../../features/menu/presentation/bloc/question/question_bloc.dart';

class AppLocator {
  static Future<void> init() async {
    //menu
    locator.registerLazySingleton<CategoryBloc>(() => CategoryBloc(locator()));
    locator.registerLazySingleton<ProductBloc>(() => ProductBloc(locator()));
    locator.registerLazySingleton<FlavorBloc>(() => FlavorBloc(locator()));
    locator.registerLazySingleton<QuestionBloc>(() => QuestionBloc(locator()));
    locator.registerLazySingleton<DiscountBloc>(() => DiscountBloc(locator()));
    locator.registerLazySingleton<GetDiscountsUsecase>(
        () => GetDiscountsUsecase(locator()));
    locator.registerLazySingleton<GetFlavorsUsecase>(
        () => GetFlavorsUsecase(locator()));
    locator.registerLazySingleton<GetQuestionsUsecase>(
        () => GetQuestionsUsecase(locator()));
    locator.registerLazySingleton<GetProductsUseCase>(
        () => GetProductsUseCase(locator()));
    locator.registerLazySingleton<GetCategoriesUseCase>(
        () => GetCategoriesUseCase(locator()));
    locator.registerLazySingleton<MenuRepository>(() => MenuRepositoryImpl(
        menuRemoteDataSource: locator(),
        menuLocalDataSource: locator(),
        networkInfo: locator()));
    locator.registerLazySingleton<MenuRemoteDataSource>(
        () => MenuRemoteDataSourceImpl(apiConsumer: locator()));
    locator.registerLazySingleton<MenuLocalDataSource>(
        () => MenuLocalDataSourceImpl(localConsumer: locator()));
  }
}
