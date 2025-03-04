import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'config/locators/global_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalLocator.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(
    DevicePreview(
        enabled: !kReleaseMode,
        data: DevicePreviewData(
          orientation: Orientation.landscape,
          textScaleFactor: 1.0,
        ),
        builder: (context) => App()),
  );
}
