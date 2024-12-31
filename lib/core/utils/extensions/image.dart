import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../assets.dart';

extension ImageExtension on BuildContext {
  ImageProvider<Object> displayBase64Image(String base64String) {
    try {
      Uint8List imageBytes = base64Decode(base64String);
      return MemoryImage(imageBytes);
    } catch (e) {
      return AssetImage(Assets.logo);
    }
  }
}
