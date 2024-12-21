import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'storage.dart';

// dependencies injector
final locator = GetIt.instance;

// theme
final themeMode = locator<AdaptiveThemeMode>();

// locales
final localArabic = Locale('ar', 'SA');
final localEnglish = Locale('en', 'US');

// storage
final storage = Storage();




