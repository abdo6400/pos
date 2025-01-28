import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'custom_form_builder_field.dart';
import '../../entities/form.dart';

class CustomFormBuilder extends StatelessWidget {
  final FormParams formModel;
  const CustomFormBuilder(this.formModel);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formModel.formKey,
      child: Wrap(
          spacing: formModel.spacing ?? 0,
          runSpacing: formModel.runSpacing ?? 0,
          children: formModel.fields
              .map(
                (e) => (CustomFormBuilderField(
                  fieldModel: e,
                  onFocus: formModel.onFocus,
                )),
              )
              .toList()),
    );
  }
}
