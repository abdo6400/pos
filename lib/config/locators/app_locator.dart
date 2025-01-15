import '../../core/utils/constants.dart';
import '../../features/menu/data/datasources/menu_local_data_source.dart';
import '../../features/menu/data/datasources/menu_remote_data_source.dart';
import '../../features/menu/data/repositories/menu_repository_impl.dart';
import '../../features/menu/domain/repositories/menu_repository.dart';
import '../../features/menu/domain/usecases/clear_orders_usecase.dart';
import '../../features/menu/domain/usecases/delete_order_usecase.dart';
import '../../features/menu/domain/usecases/get_categories_usecase.dart';
import '../../features/menu/domain/usecases/get_discounts_usecase.dart';
import '../../features/menu/domain/usecases/get_flavors_usecase.dart';
import '../../features/menu/domain/usecases/get_offers_usecase.dart';
import '../../features/menu/domain/usecases/get_orders_usecase.dart';
import '../../features/menu/domain/usecases/get_products_usecase.dart';
import '../../features/menu/domain/usecases/get_questions_usecase.dart';
import '../../features/menu/domain/usecases/insert_order_usecase.dart';
import '../../features/menu/presentation/bloc/category/category_bloc.dart';
import '../../features/menu/presentation/bloc/discount/discount_bloc.dart';
import '../../features/menu/presentation/bloc/flavor/flavor_bloc.dart';
import '../../features/menu/presentation/bloc/offer/offer_bloc.dart';
import '../../features/menu/presentation/bloc/order/order_bloc.dart';
import '../../features/menu/presentation/bloc/product/product_bloc.dart';
import '../../features/menu/presentation/bloc/question/question_bloc.dart';
import '../../features/settings/data/datasources/settings_remote_data_source.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_settings_usecase.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';

class AppLocator {
  static Future<void> init() async {
    //menu
    locator.registerLazySingleton<CategoryBloc>(() => CategoryBloc(locator()));
    locator.registerLazySingleton<ProductBloc>(() => ProductBloc(locator()));
    locator.registerLazySingleton<FlavorBloc>(() => FlavorBloc(locator()));
    locator.registerLazySingleton<QuestionBloc>(() => QuestionBloc(locator()));
    locator.registerLazySingleton<DiscountBloc>(() => DiscountBloc(locator()));
    locator.registerLazySingleton<OfferBloc>(() => OfferBloc(locator()));
    locator.registerLazySingleton<OrderBloc>(
        () => OrderBloc(locator(), locator(), locator(), locator()));
    locator.registerLazySingleton<GetOrdersUseCase>(
        () => GetOrdersUseCase(locator()));
    locator.registerLazySingleton<ClearOrdersUseCase>(
        () => ClearOrdersUseCase(locator()));
    locator.registerLazySingleton<DeleteOrderUseCase>(
        () => DeleteOrderUseCase(locator()));
    locator.registerLazySingleton<InsertOrderUseCase>(
        () => InsertOrderUseCase(locator()));
    locator.registerLazySingleton<GetOffersUseCase>(
        () => GetOffersUseCase(locator()));
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

    //settings
    locator.registerLazySingleton<SettingsBloc>(() => SettingsBloc(locator()));
    locator.registerLazySingleton<GetSettingsUsecase>(
        () => GetSettingsUsecase(locator()));
    locator.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(settingsRemoteDataSource: locator()));
    locator.registerLazySingleton<SettingsRemoteDataSource>(
        () => SettingsRemoteDataSourceImpl(apiConsumer: locator()));
  }
}
