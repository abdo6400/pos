import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../entities/field.dart';
import '../../utils/enums/field_type_enums.dart';

class CustomFormBuilderField extends StatelessWidget {
  final FieldParams fieldModel;
  final Function(String)? onFocus;
  static bool obscureText = true;
  const CustomFormBuilderField({
    super.key,
    required this.fieldModel,
    required this.onFocus,
  });

  @override
  Widget build(BuildContext context) {
    switch (fieldModel.type) {
      case FieldTypeEnums.text:
        return _buildTextField(context);
      case FieldTypeEnums.checkbox:
        return _buildCheckbox(context);
      case FieldTypeEnums.checkboxGroup:
        return _buildCheckboxGroup(context);
      case FieldTypeEnums.choiceChip:
        return _buildChoiceChip(context);
      case FieldTypeEnums.dateRangePicker:
        return _buildDateRangePicker(context);
      case FieldTypeEnums.dateTimePicker:
        return _buildDateTimePicker(context);
      case FieldTypeEnums.dropdown:
        return _buildDropdown(context);
      case FieldTypeEnums.filterChip:
        return _buildFilterChip(context);
      case FieldTypeEnums.radioGroup:
        return _buildRadioGroup(context);
      case FieldTypeEnums.rangeSlider:
        return _buildRangeSlider(context);
      case FieldTypeEnums.slider:
        return _buildSlider(context);
      case FieldTypeEnums.switchField:
        return _buildSwitch(context);
    }
  }

  Widget _buildTextField(BuildContext context) {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).hintColor.withAlpha(100)),
    );
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: context.AppResponsiveValue(10,
              mobile: 5, tablet: 20, desktop: 25),
          horizontal: context.AppResponsiveValue(10,
              mobile: 5, tablet: 40, desktop: 45),
        ),
        child: StatefulBuilder(builder: (BuildContext context, setState) {
          return FormBuilderTextField(
            onTap: onFocus != null ? () => onFocus!(fieldModel.label) : null,
            name: fieldModel.label,
            initialValue: fieldModel.initialValue,
            obscureText: fieldModel.isPassword ? obscureText : false,
            maxLines: fieldModel.isPassword ? 1 : fieldModel.maxLines,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: context.AppResponsiveValue(12,
                      mobile: 12, tablet: 20, desktop: 24),
                ),
            decoration: InputDecoration(
              labelText: fieldModel.label.tr(),
              floatingLabelStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(
                    color: Theme.of(context).hintColor.withValues(alpha: 0.9),
                    fontSize: context.AppResponsiveValue(14,
                        mobile: 13, tablet: 22, desktop: 25),
                  ),
              labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).hintColor.withValues(alpha: 0.9),
                    fontSize: context.AppResponsiveValue(14,
                        mobile: 13, tablet: 22, desktop: 25),
                  ),
              hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).hintColor.withValues(alpha: 0.9),
                    fontSize: context.AppResponsiveValue(14,
                        mobile: 13, tablet: 22, desktop: 25),
                  ),
              hintFadeDuration: Duration(milliseconds: 1000),
              errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: context.AppResponsiveValue(14,
                        mobile: 13, tablet: 20, desktop: 24),
                  ),
              contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 20),
              border: border,
              enabledBorder: border,
              suffixIcon: fieldModel.isPassword
                  ? InkWell(
                      onTap: () => setState(() => obscureText = !obscureText),
                      child: obscureText
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: Theme.of(context)
                                  .hintColor
                                  .withValues(alpha: 0.9),
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: Theme.of(context)
                                  .hintColor
                                  .withValues(alpha: 0.9),
                            ),
                    )
                  : null,
              prefixIcon: Container(
                margin: EdgeInsetsDirectional.only(end: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Icon(
                  fieldModel.icon,
                  color: Colors.white,
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: context.AppResponsiveValue(60,
                    mobile: 40, tablet: 75, desktop: 80),
                minHeight: context.AppResponsiveValue(45,
                    mobile: 40, tablet: 60, desktop: 65),
              ),
            ),
            validator: FormBuilderValidators.compose(fieldModel.validators),
          );
        }));
  }

  Widget _buildDateTimePicker(BuildContext context) {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).hintColor.withAlpha(100)),
    );
    return FormBuilderDateTimePicker(
      name: fieldModel.label,
      initialValue: DateTime.now(),
      inputType: InputType.date,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: context.AppResponsiveValue(12,
                mobile: 12, tablet: 20, desktop: 24),
          ),
      decoration: InputDecoration(
        labelText: fieldModel.label.tr(),
        floatingLabelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).hintColor.withValues(alpha: 0.9),
              fontSize: context.AppResponsiveValue(14,
                  mobile: 13, tablet: 22, desktop: 25),
            ),
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).hintColor.withValues(alpha: 0.9),
              fontSize: context.AppResponsiveValue(14,
                  mobile: 13, tablet: 22, desktop: 25),
            ),
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).hintColor.withValues(alpha: 0.9),
              fontSize: context.AppResponsiveValue(14,
                  mobile: 13, tablet: 22, desktop: 25),
            ),
        hintFadeDuration: Duration(milliseconds: 1000),
        errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.error,
              fontSize: context.AppResponsiveValue(14,
                  mobile: 13, tablet: 20, desktop: 24),
            ),
        contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 20),
        border: border,
        enabledBorder: border,
        prefixIcon:
            Icon(fieldModel.icon, color: Theme.of(context).primaryColor),
        prefixIconConstraints: BoxConstraints(
          minWidth: context.AppResponsiveValue(60,
              mobile: 40, tablet: 75, desktop: 80),
          minHeight: context.AppResponsiveValue(45,
              mobile: 40, tablet: 60, desktop: 65),
        ),
      ),
      // validator: FormBuilderValidators.compose(fieldModel.validators),
    );
  }

  Widget _buildCheckbox(BuildContext context) {
    return FormBuilderCheckbox(
      name: fieldModel.label,
      initialValue: fieldModel.initialValue == 'true',
      title: Text(fieldModel.label),
      // validator: FormBuilderValidators.compose(fieldModel.validators),
    );
  }

  Widget _buildCheckboxGroup(BuildContext context) {
    return FormBuilderCheckboxGroup(
      name: fieldModel.label,
      options: fieldModel.options!
          .map((option) =>
              FormBuilderFieldOption(value: option, child: Text(option)))
          .toList(),
      initialValue:
          fieldModel.initialValue != null ? [fieldModel.initialValue] : null,
      // validator: FormBuilderValidators.compose(fieldModel.validators),
    );
  }

  Widget _buildChoiceChip(BuildContext context) {
    return FormBuilderChoiceChip(
      name: fieldModel.label,
      options: fieldModel.options!
          .map((option) =>
              FormBuilderChipOption(value: option, child: Text(option)))
          .toList(),
      initialValue: fieldModel.initialValue,
      validator: FormBuilderValidators.compose(fieldModel.validators),
    );
  }

  Widget _buildDateRangePicker(BuildContext context) {
    return FormBuilderDateRangePicker(
      name: fieldModel.label,
      firstDate: DateTime(1000),
      lastDate: DateTime(3000),
      initialValue: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 7)),
      ),
      decoration: InputDecoration(
        labelText: fieldModel.label,
        prefixIcon: Icon(fieldModel.icon),
      ),
      // validator: FormBuilderValidators.compose(fieldModel.validators),
    );
  }

  Widget _buildDropdown(BuildContext context) {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).hintColor.withAlpha(100)),
    );
    return FormBuilderDropdown(
      name: fieldModel.label,
      items: fieldModel.options!
          .map((option) => DropdownMenuItem(value: option, child: Text(option)))
          .toList(),
      initialValue: fieldModel.initialValue,
      decoration: InputDecoration(
        labelText: fieldModel.label.tr(),
        border: border,
        enabledBorder: border,
        prefixIcon:
            Icon(fieldModel.icon, color: Theme.of(context).primaryColor),
      ),
      validator: FormBuilderValidators.compose(fieldModel.validators),
    );
  }

  Widget _buildFilterChip(BuildContext context) {
    return FormBuilderFilterChip(
      name: fieldModel.label,
      options: fieldModel.options!
          .map((option) =>
              FormBuilderChipOption(value: option, child: Text(option)))
          .toList(),
      initialValue:
          fieldModel.initialValue != null ? [fieldModel.initialValue] : null,
      // validator: FormBuilderValidators.compose(fieldModel.validators),
    );
  }

  Widget _buildRadioGroup(BuildContext context) {
    return FormBuilderRadioGroup(
      name: fieldModel.label,
      options: fieldModel.options!
          .map((option) =>
              FormBuilderFieldOption(value: option, child: Text(option)))
          .toList(),
      initialValue: fieldModel.initialValue,
      validator: FormBuilderValidators.compose(fieldModel.validators),
    );
  }

  Widget _buildRangeSlider(BuildContext context) {
    return FormBuilderRangeSlider(
      name: fieldModel.label,
      min: fieldModel.min ?? 0,
      max: fieldModel.max ?? 100,
      initialValue: const RangeValues(20, 80),
      // validator: FormBuilderValidators.compose(fieldModel.validators),
    );
  }

  Widget _buildSlider(BuildContext context) {
    return FormBuilderSlider(
      name: fieldModel.label,
      min: fieldModel.min ?? 0,
      max: fieldModel.max ?? 100,
      initialValue: 50,
      // validator: FormBuilderValidators.compose(fieldModel.validators),
    );
  }

  Widget _buildSwitch(BuildContext context) {
    return FormBuilderSwitch(
      name: fieldModel.label,
      initialValue: fieldModel.initialValue == 'true',
      title: Text(fieldModel.label),
      // validator: FormBuilderValidators.compose(fieldModel.validators),
    );
  }
}
