import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../assets.dart';

extension ImageExtension on BuildContext {
  ImageProvider<Object> displayBase64Image(String base64String) {
    try {
      // Decode the Base64 string to bytes
      Uint8List imageBytes = base64Decode(base64String);

      // Use Image.memory to display the image
      return MemoryImage(imageBytes);
    } catch (e) {
      return AssetImage(Assets.logo);
    }
  }
}
