import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'custom_form_builder_text_field.dart';
import '../../entities/form.dart';

class CustomFormBuilder extends StatelessWidget {
  final FormParams formModel;
  const CustomFormBuilder(this.formModel);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formModel.formKey,
      child: Wrap(
          children: formModel.fields
              .map(
                (e) => (CustomFormBuilderTextField(
                  fieldModel: e,
                )),
              )
              .toList()),
    );
  }
}
