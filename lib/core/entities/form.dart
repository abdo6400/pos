import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'field.dart';

class FormParams {
  final GlobalKey<FormBuilderState> formKey;
  final List<FieldParams> fields;
  Function(String)? onFocus;
  final ResponsiveRowColumnType? layout;
  final double? spacing;

  final double? runSpacing;

  FormParams(
      {required this.formKey,
      required this.fields,
      this.layout,
      this.onFocus,
      this.spacing,
      this.runSpacing});
}
