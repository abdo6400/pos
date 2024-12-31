import 'dart:math';

import 'package:flutter/material.dart';

extension ConvertColor on BuildContext {
  Color convertStringToColor(String colorString) {
    // Extract the numeric part from the string
    final decimalColor = int.parse(colorString.split(':').last.trim());

    // Convert the negative number to its unsigned 32-bit representation
    int unsignedColor = decimalColor & 0xFFFFFFFF;

    // Extract ARGB components
    int alpha = (unsignedColor >> 24) & 0xFF;
    int red = (unsignedColor >> 16) & 0xFF;
    int green = (unsignedColor >> 8) & 0xFF;
    int blue = unsignedColor & 0xFF;

    // Return a Flutter Color object
    return Color.fromARGB(alpha, red, green, blue);
  }

  Color generateRandomColor() {
    final random = Random();
    // Generate random values for red, green, blue, and alpha (fully opaque).
    int alpha = 255; // Fully opaque
    int red = random.nextInt(256); // 0 to 255
    int green = random.nextInt(256); // 0 to 255
    int blue = random.nextInt(256); // 0 to 255

    return Color.fromARGB(alpha, red, green, blue);
  }

  Color generateColorFromValue(String value, {double darkenFactor = 0.0}) {
    // Ensure the darken factor is within 0.0 to 1.0
    assert(darkenFactor >= 0.0 && darkenFactor <= 1.0,
        'Darken factor must be between 0.0 and 1.0');

    // Compute a hash code from the string value
    int hash = value.hashCode;

    // Use the hash to generate RGB values
    int red = (hash & 0xFF0000) >> 16; // Extract the first 8 bits
    int green = (hash & 0x00FF00) >> 8; // Extract the next 8 bits
    int blue = (hash & 0x0000FF); // Extract the last 8 bits

    // Apply the darken factor
    red = (red * (1 - darkenFactor)).clamp(0, 255).toInt();
    green = (green * (1 - darkenFactor)).clamp(0, 255).toInt();
    blue = (blue * (1 - darkenFactor)).clamp(0, 255).toInt();

    // Return the color with full opacity
    return Color.fromARGB(255, red, green, blue);
  }
}
