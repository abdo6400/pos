import 'package:flutter/material.dart';

class FieldParams {
  String label;
  String? hint;
  String?initialValue;
  int? maxLines;
  IconData icon;
  List<String? Function(String?)> validators;
  bool isPassword = false;
  FieldParams({
    required this.label,
    this.hint,
    this.initialValue,
    this.maxLines,
    required this.icon,
    required this.validators,
    this.isPassword = false,
  });
}
