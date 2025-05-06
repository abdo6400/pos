import 'package:retail/features/close_cashbox/domain/usecases/close_point_usecase.dart';
import 'package:retail/features/sales/data/datasources/sales_remote_data_source.dart';
import 'package:retail/features/sales/domain/repositories/sales_repository.dart';
import 'package:retail/features/sales/domain/usecases/get_invoice_detail_usecase.dart';
import 'package:retail/features/sales/domain/usecases/get_invoices_usecase.dart';

import '../../core/utils/constants.dart';
import '../../features/close_cashbox/data/datasources/close_point_remote_data_source.dart';
import '../../features/close_cashbox/data/repositories/close_point_repository_impl.dart';
import '../../features/close_cashbox/domain/repositories/close_point_repository.dart';
import '../../features/close_cashbox/domain/usecases/get_cash_sale_summary_usecase.dart';
import '../../features/close_cashbox/domain/usecases/get_payments_summary_usecase.dart';
import '../../features/close_cashbox/domain/usecases/get_sales_summary_usecase.dart';
import '../../features/close_cashbox/presentation/bloc/close_cashbox_bloc.dart';
import '../../features/close_cashbox/presentation/bloc/summary/summary_bloc.dart';
import '../../features/menu/data/datasources/menu_local_data_source.dart';
import '../../features/menu/data/datasources/menu_remote_data_source.dart';
import '../../features/menu/data/repositories/menu_repository_impl.dart';
import '../../features/menu/domain/repositories/menu_repository.dart';
import '../../features/menu/domain/usecases/clear_orders_usecase.dart';
import '../../features/menu/domain/usecases/delete_order_usecase.dart';
import '../../features/menu/domain/usecases/get_categories_usecase.dart';
import '../../features/menu/domain/usecases/get_deliveries_usecase.dart';
import '../../features/menu/domain/usecases/get_delivery_discounts_usecase.dart';
import '../../features/menu/domain/usecases/get_discounts_usecase.dart';
import '../../features/menu/domain/usecases/get_flavors_usecase.dart';
import '../../features/menu/domain/usecases/get_offers_usecase.dart';
import '../../features/menu/domain/usecases/get_orders_usecase.dart';
import '../../features/menu/domain/usecases/get_products_usecase.dart';
import '../../features/menu/domain/usecases/get_questions_usecase.dart';
import '../../features/menu/domain/usecases/insert_order_usecase.dart';
import '../../features/menu/presentation/bloc/category/category_bloc.dart';
import '../../features/menu/presentation/bloc/delivery/delivery_bloc.dart';
import '../../features/menu/presentation/bloc/discount/discount_bloc.dart';
import '../../features/menu/presentation/bloc/flavor/flavor_bloc.dart';
import '../../features/menu/presentation/bloc/offer/offer_bloc.dart';
import '../../features/menu/presentation/bloc/order/order_bloc.dart';
import '../../features/menu/presentation/bloc/product/product_bloc.dart';
import '../../features/menu/presentation/bloc/question/question_bloc.dart';
import '../../features/payment/data/datasources/payment_local_data_source.dart';
import '../../features/payment/data/datasources/payment_remote_data_source.dart';
import '../../features/payment/data/repositories/payment_repository_impl.dart';
import '../../features/payment/domain/repositories/payment_repository.dart';
import '../../features/payment/domain/usecases/get_payment_types_usecase.dart';
import '../../features/payment/domain/usecases/pay_usecase.dart';
import '../../features/payment/presentation/bloc/pay/pay_bloc.dart';
import '../../features/payment/presentation/bloc/payment_types/payment_types_bloc.dart';
import '../../features/sales/data/repositories/sales_repository_impl.dart';
import '../../features/sales/domain/usecases/get_returned_invoice_detail_usecase.dart';
import '../../features/sales/domain/usecases/get_returned_invoices_usecase.dart';
import '../../features/sales/domain/usecases/return_invoice_usecase.dart';
import '../../features/sales/presentation/bloc/invoice/invoice_bloc.dart';
import '../../features/sales/presentation/bloc/invoice_detail/invoice_detail_bloc.dart';
import '../../features/sales/presentation/bloc/return_invoice/return_invoice_bloc.dart';
import '../../features/settings/data/datasources/settings_remote_data_source.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/end_day_usecase.dart';
import '../../features/settings/domain/usecases/get_opened_points_usecase.dart';
import '../../features/settings/domain/usecases/get_sales_by_user_usecase.dart';
import '../../features/settings/domain/usecases/get_sales_by_warehouse_usecase.dart';
import '../../features/settings/domain/usecases/get_settings_usecase.dart';
import '../../features/settings/domain/usecases/open_point_by_parameters_usecase.dart';
import '../../features/settings/presentation/bloc/checker_point/checker_point_bloc.dart';
import '../../features/settings/presentation/bloc/end_day/end_day_bloc.dart';
import '../../features/settings/presentation/bloc/get_sales_by_user/get_sales_by_user_bloc.dart';
import '../../features/settings/presentation/bloc/get_sales_by_warehouse/get_sales_by_warehouse_bloc.dart';
import '../../features/settings/presentation/bloc/open_point/open_point_bloc.dart';
import '../../features/settings/presentation/bloc/opened_point/opened_points_bloc.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';

class AppLocator {
  static Future<void> init() async {
    //menu
    locator.registerFactory<CategoryBloc>(() => CategoryBloc(locator()));
    locator.registerFactory<ProductBloc>(() => ProductBloc(locator()));
    locator.registerFactory<FlavorBloc>(() => FlavorBloc(locator()));
    locator.registerFactory<QuestionBloc>(() => QuestionBloc(locator()));
    locator.registerFactory<DiscountBloc>(() => DiscountBloc(locator()));
    locator.registerFactory<OfferBloc>(() => OfferBloc(locator()));
    locator.registerFactory<OrderBloc>(
        () => OrderBloc(locator(), locator(), locator(), locator()));
    locator.registerFactory<DeliveryBloc>(
        () => DeliveryBloc(locator(), locator()));
    locator.registerLazySingleton<GetDeliveryDiscountsUsecase>(
        () => GetDeliveryDiscountsUsecase(locator()));
    locator.registerLazySingleton<GetDeliveriesUsecase>(
        () => GetDeliveriesUsecase(locator()));
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
    locator.registerFactory<SettingsBloc>(() => SettingsBloc(locator()));
    locator.registerFactory<EndDayBloc>(() => EndDayBloc(locator()));
    locator
        .registerFactory<OpenedPointsBloc>(() => OpenedPointsBloc(locator()));
    locator.registerFactory<GetSalesByUserBloc>(
        () => GetSalesByUserBloc(locator()));
    locator.registerFactory<GetSalesByWarehouseBloc>(
        () => GetSalesByWarehouseBloc(locator()));
    locator.registerFactory<OpenPointBloc>(() => OpenPointBloc(locator()));
    locator.registerLazySingleton<GetOpenedPointsUsecase>(
        () => GetOpenedPointsUsecase(locator()));
    locator.registerLazySingleton<GetSettingsUsecase>(
        () => GetSettingsUsecase(locator()));
    locator.registerLazySingleton<GetSalesByWarehouseUsecase>(
        () => GetSalesByWarehouseUsecase(locator()));
    locator.registerLazySingleton<GetSalesByUserUsecase>(
        () => GetSalesByUserUsecase(locator()));
    locator.registerLazySingleton<OpenPointByParametersUsecase>(
        () => OpenPointByParametersUsecase(locator()));
    locator
        .registerLazySingleton<EndDayUsecase>(() => EndDayUsecase(locator()));
    locator.registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImpl(settingsRemoteDataSource: locator()));
    locator.registerLazySingleton<SettingsRemoteDataSource>(
        () => SettingsRemoteDataSourceImpl(apiConsumer: locator()));

    //payment
    locator.registerFactory<PayBloc>(() => PayBloc(locator()));
    locator
        .registerFactory<PaymentTypesBloc>(() => PaymentTypesBloc(locator()));
    locator.registerLazySingleton<PayUsecase>(() => PayUsecase(locator()));
    locator.registerLazySingleton<GetPaymentTypesUsecase>(
        () => GetPaymentTypesUsecase(locator()));
    locator.registerLazySingleton<PaymentRepository>(() =>
        PaymentRepositoryImpl(
            paymentRemoteDataSource: locator(),
            paymentLocalDataSource: locator(),
            networkInfo: locator()));
    locator.registerLazySingleton<PaymentRemoteDataSource>(
        () => PaymentRemoteDataSourceImpl(apiConsumer: locator()));
    locator.registerLazySingleton<PaymentLocalDataSource>(
        () => PaymentLocalDataSourceImpl(localConsumer: locator()));

    //sales
    locator.registerFactory<CheckerPointBloc>(() => CheckerPointBloc(
          locator(),
          locator(),
          locator(),
        ));
    locator.registerFactory<InvoiceBloc>(() => InvoiceBloc(
          locator(),
          locator(),
        ));
    locator
        .registerFactory<ReturnInvoiceBloc>(() => ReturnInvoiceBloc(locator()));
    locator.registerFactory<InvoiceDetailBloc>(() => InvoiceDetailBloc(
          locator(),
          locator(),
        ));
    locator.registerLazySingleton<ReturnInvoiceUsecase>(
        () => ReturnInvoiceUsecase(locator()));
    locator.registerLazySingleton<GetInvoicesUsecase>(
        () => GetInvoicesUsecase(locator()));
    locator.registerLazySingleton<GetInvoiceDetailUsecase>(
        () => GetInvoiceDetailUsecase(locator()));
    locator.registerLazySingleton<GetReturnedInvoicesUsecase>(
        () => GetReturnedInvoicesUsecase(locator()));
    locator.registerLazySingleton<GetReturnedInvoiceDetailUsecase>(
        () => GetReturnedInvoiceDetailUsecase(locator()));
    locator.registerLazySingleton<SalesRepository>(() => SalesRepositoryImpl(
          salesRemoteDataSource: locator(),
        ));
    locator.registerLazySingleton<SalesRemoteDataSource>(
        () => SalesRemoteDataSourceImpl(apiConsumer: locator()));

    //close point
    locator.registerFactory<SummaryBloc>(
        () => SummaryBloc(locator(), locator(), locator(),locator()));
    locator
        .registerFactory<CloseCashboxBloc>(() => CloseCashboxBloc(locator()));
    locator.registerLazySingleton<GetPaymentsSummaryUseCase>(
        () => GetPaymentsSummaryUseCase(locator()));
    locator.registerLazySingleton<GetCashSaleSummaryUsecase>(
        () => GetCashSaleSummaryUsecase(locator()));
    locator.registerLazySingleton<ClosePointUsecase>(
        () => ClosePointUsecase(locator()));
    locator.registerLazySingleton<GetSalesSummaryUsecase>(
        () => GetSalesSummaryUsecase(locator()));
    locator.registerLazySingleton<ClosePointRepository>(
        () => ClosePointRepositoryImpl(closePointRemoteDataSource: locator()));
    locator.registerLazySingleton<ClosePointRemoteDataSource>(
        () => ClosePointRemoteDataSourceImpl(apiConsumer: locator()));
  }
}
