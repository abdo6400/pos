import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/global_form_builder/custom_form_builder.dart';
import '../../../../core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../core/entities/field.dart';
import '../../../../core/entities/form.dart';
import '../../../../core/utils/enums/string_enums.dart';
import 'custom_sign_button.dart';

class LoginFormBuilder extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey;
  final VoidCallback onSubmit;
  final VoidCallback onReset;
  final VoidCallback onLoginWithGoogle;
  const LoginFormBuilder({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required this.onSubmit,
    required this.onReset,
    required this.onLoginWithGoogle,
  }) : _formKey = formKey;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor.withValues(alpha: 0.8),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical:
              context.ResponsiveValu(10, mobile: 10, tablet: 20, desktop: 35),
        ),
        child: Column(
          spacing:
              context.ResponsiveValu(8, mobile: 5, tablet: 20, desktop: 35),
          mainAxisSize: MainAxisSize.min,
          children: [
            AppLogo(),
            CustomFormBuilder(FormParams(
              formKey: _formKey,
              fields: [
                FieldParams(
                  label: StringEnums.email.name,
                  validators: [],
                  icon: Icons.email_outlined,
                ),
                FieldParams(
                    label: StringEnums.password.name,
                    isPassword: true,
                    icon: Icons.lock_outline,
                    validators: []),
              ],
            )),
            CustomSignButton(
              buttonLabel: StringEnums.login.name,
              onSubmit: () {
                if (_formKey.currentState!.saveAndValidate()) {
                  onSubmit();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
