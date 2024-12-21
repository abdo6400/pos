import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'field.dart';

class FormParams {
  final GlobalKey<FormBuilderState> formKey;
  final List<FieldParams> fields;


  FormParams(
      {required this.formKey, required this.fields});
}
