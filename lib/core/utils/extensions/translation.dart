import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

extension Translation on BuildContext {
  String trValue(String arValue, String enValue) =>
      this.locale.languageCode != localEnglish.languageCode ? arValue : enValue;
}
