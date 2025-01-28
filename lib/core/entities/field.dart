import 'package:flutter/material.dart';

import '../utils/enums/field_type_enums.dart';

class FieldParams {
  String label;
  String? hint;
  String? initialValue;
  int? maxLines;
  IconData icon;
  List<String? Function(String?)> validators;
  bool isPassword;
  FieldTypeEnums type;
  List<String>? options; // For fields like dropdown, checkboxGroup, etc.
  double? min; // For slider and rangeSlider
  double? max; // For slider and rangeSlider

  FieldParams({
    required this.label,
    this.hint,
    this.initialValue,
    this.maxLines,
    required this.icon,
    required this.validators,
    this.isPassword = false,
    required this.type,
    this.options,
    this.min,
    this.max,
  });
}
