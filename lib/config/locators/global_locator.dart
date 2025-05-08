import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printer_service/thermal_printer.dart';
import '../../core/utils/constants.dart';
import '../database/api/api_consumer.dart';
import '../database/api/dio_consumer.dart';
import '../database/cache/cache_consumer.dart';
import '../database/cache/secure_cache_helper.dart';
import '../database/local/local_consumer.dart';
import '../database/local/sqlflite_consumer.dart';
import '../database/network/netwok_info.dart';
import '../observers/bloc_observer.dart';
import '../services/Imin_printer_service.dart';
import '../services/bluethooth_printer_service.dart';
import '../services/network_printer_service.dart';
import '../services/printing_service.dart';
import '../services/usb_printer_service.dart';
import 'app_locator.dart';
import 'auth_locator.dart';
import 'constant_locator.dart';

class GlobalLocator {
  static Future<void> init() async {
    await AuthLocator.init();
    await AppLocator.init();
    await ConstantLocator.init();
    // Internal
    locator.registerLazySingleton<PrintingService>(() => PrintingServiceImpl(
        iminPrinterService: locator(),
        bluetoothPrinterService: locator(),
        networkPrinterService: locator(),
        usbPrinterService: locator()));
    locator.registerLazySingleton<BluetoothPrinterService>(
        () => BluetoothPrinterService(printerManager: locator()));
    locator.registerLazySingleton<NetworkPrinterService>(
        () => NetworkPrinterService(printerManager: locator()));
    locator.registerLazySingleton<UsbPrinterService>(
        () => UsbPrinterService(printerManager: locator()));
    locator
        .registerLazySingleton<IminPrinterService>(() => IminPrinterService());
    await EasyLocalization.ensureInitialized();
    final themeMode =
        await AdaptiveTheme.getThemeMode() ?? AdaptiveThemeMode.system;
    locator.registerLazySingleton<AdaptiveThemeMode>(() => themeMode);
    locator.registerLazySingleton<CacheConsumer>(
        () => SecureCacheHelper(sharedPref: locator()));
    locator.registerLazySingleton<ApiConsumer>(
        () => DioConsumer(client: locator(), networkInfo: locator()));
    locator.registerLazySingleton<LocalConsumer>(() => SqlfliteConsumer());
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
    );
    Bloc.observer = MyBlocObserver();
    // Extarnal
    locator.registerLazySingleton(() => Dio());
    locator.registerLazySingleton(() => PrinterManager.instance);
    locator.registerLazySingleton(() => FlutterSecureStorage());
    locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  }
}
