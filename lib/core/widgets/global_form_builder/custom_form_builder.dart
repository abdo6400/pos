import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'custom_form_builder_field.dart';
import '../../entities/form.dart';

class CustomFormBuilder extends StatelessWidget {
  final FormParams formModel;
  const CustomFormBuilder(this.formModel);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formModel.formKey,
      child: ResponsiveRowColumn(
          layout: formModel.layout ?? ResponsiveRowColumnType.COLUMN,
          rowSpacing: formModel.spacing ?? 0,
          columnSpacing: formModel.spacing ?? 0,
          children: formModel.fields
              .map(
                (e) => ResponsiveRowColumnItem(
                  rowFlex: 1,
                  child: (CustomFormBuilderField(
                    fieldModel: e,
                    onFocus: formModel.onFocus,
                  )),
                ),
              )
              .toList()),
    );
  }
}
