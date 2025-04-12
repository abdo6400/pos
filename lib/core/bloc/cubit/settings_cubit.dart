import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/settings.dart';
import '../../models/settings_model.dart';
import '../../utils/constants.dart';

class SettingsCubit extends Cubit<Settings> {
  SettingsCubit()
      : super(SettingsModel(
          stationName: "",
          printerId: 1,
          printerCashIp: "",
          printerKitchenIp1: "",
          printerKitchenIp2: "",
          printerKitchenIp3: "",
          printerKitchenIp4: "",
        ));

  void setSettings() async {
    final Settings? settings = await storage.getSettings();
    if (settings != null) {
      emit(settings);
    }
  }

  void saveSettings() async {
    final Settings settings = SettingsModel(
      stationName: state.stationName,
      printerId: state.printerId,
      printerCashIp: state.printerCashIp,
      printerKitchenIp1: state.printerKitchenIp1,
      printerKitchenIp2: state.printerKitchenIp2,
      printerKitchenIp3: state.printerKitchenIp3,
      printerKitchenIp4: state.printerKitchenIp4,
    );
    await storage.saveSettings(settings);
    emit(settings);
  }
}
