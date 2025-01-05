import 'package:awesome_dialog/awesome_dialog.dart';
import '../../utils/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../widgets/global_form_builder/custom_form_builder.dart';
import '../../entities/form.dart';
import '../enums/string_enums.dart';

extension Dialogs on BuildContext {
  void showFormDialog({
    required FormParams formModel,
    String? title,
    String? subtitle,
    required String btnLabel,
    required void Function(Map<String, dynamic> data) onSubmit,
  }) {
    AwesomeDialog(
      context: this,
      autoDismiss: false,
      useRootNavigator: true,
      btnCancelText: StringEnums.cancel.name.tr(),
      titleTextStyle: Theme.of(this).textTheme.headlineSmall!.copyWith(
            fontSize:
                this.ResponsiveValu(20, mobile: 15, tablet: 24, desktop: 32),
          ),
      buttonsTextStyle: Theme.of(this).textTheme.bodyLarge!.copyWith(
            fontSize:
                this.ResponsiveValu(16, mobile: 15, tablet: 24, desktop: 32),
          ),
      btnCancelOnPress: () {
        Navigator.pop(this);
      },
      onDismissCallback: (type) {
        return;
      },
      btnOkOnPress: () {
        if (formModel.formKey.currentState != null &&
            formModel.formKey.currentState!.saveAndValidate()) {
          Navigator.pop(this);
          onSubmit(formModel.formKey.currentState!.value);
        }
      },
      animType: AnimType.topSlide,
      dialogType: DialogType.noHeader,
      btnOkText: btnLabel.tr(),
      buttonsBorderRadius: BorderRadius.circular(5),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 20),
      body: Column(
        children: <Widget>[
          if (title != null)
            Text(
              title.tr(),
              style: Theme.of(this).textTheme.headlineSmall!.copyWith(
                    fontSize: this.ResponsiveValu(20,
                        mobile: 15, tablet: 24, desktop: 32),
                  ),
            ),
          SizedBox(height: 10),
          Divider(),
          SizedBox(height: 10),
          CustomFormBuilder(formModel)
        ],
      ),
    )..show();
  }

  void showConfirmDilog({
    required String title,
    String? subtitle,
    required void Function() onSubmit,
  }) {
    AwesomeDialog(
      context: this,
      useRootNavigator: true,
      btnCancelText: StringEnums.cancel.name.tr(),
      animType: AnimType.topSlide,
      btnOkText: StringEnums.confirm.name.tr(),
      dialogType: DialogType.warning,
      titleTextStyle: Theme.of(this).textTheme.headlineSmall!.copyWith(
            fontSize:
                this.ResponsiveValu(20, mobile: 15, tablet: 24, desktop: 32),
          ),
      title: title.tr(),
      btnCancelOnPress: () {},
      onDismissCallback: (type) {
        return;
      },
      btnOkOnPress: () => onSubmit(),
    )..show();
  }

  void showCustomDialog({
    required String title,
    String? subtitle,
    String? image,
    required Widget child,
    required void Function() onSubmit,
  }) {
    AwesomeDialog(
      context: this,
      useRootNavigator: false,
      btnCancelText: StringEnums.cancel.name.tr(),
      buttonsTextStyle: Theme.of(this).textTheme.bodyLarge!.copyWith(
            color: Colors.white,
            fontSize:
                this.ResponsiveValu(16, mobile: 15, tablet: 24, desktop: 32),
          ),
      btnOkOnPress: () => onSubmit(),
      btnCancelOnPress: () {},
      onDismissCallback: (type) {
        return;
      },
      animType: AnimType.topSlide,
      dialogType: DialogType.noHeader,
      btnOkText: StringEnums.confirm.name.tr(),
      buttonsBorderRadius: BorderRadius.circular(5),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 20),
      body: Column(
        spacing: 10,
        children: [
          Text(
            title.tr(),
            style: Theme.of(this).textTheme.headlineSmall!.copyWith(
                  fontSize: this
                      .ResponsiveValu(20, mobile: 15, tablet: 24, desktop: 32),
                ),
          ),
          Divider(),
          child
        ],
      ),
    )..show();
  }
}
