import '../../../../../core/components/global_form_builder/custom_form_builder.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../../core/entities/field.dart';
import '../../../../../core/entities/form.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../custom_sign_button.dart';
import '../sign_with_social.dart';

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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          Container(
            padding: EdgeInsets.symmetric(
              vertical: context.ResponsiveValu(10,
                  mobile: 5, tablet: 15, desktop: 20),
              horizontal: context.ResponsiveValu(15,
                  mobile: 5, tablet: 50, desktop: 30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => onReset(),
                  child: Text(StringEnums.forgot_password.name.tr(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            decoration: TextDecoration.underline,
                            fontSize: context.ResponsiveValu(12,
                                mobile: 8, tablet: 16, desktop: 20),
                          )),
                ),
              ],
            ),
          ),
          SizedBox(
            height:
                context.ResponsiveValu(20, mobile: 10, tablet: 30, desktop: 35),
          ),
          CustomSignButton(
            buttonLabel: StringEnums.login.name,
            iconData: Icons.login_rounded,
            onSubmit: () {
              if (_formKey.currentState!.saveAndValidate()) {
                onSubmit();
              }
            },
          ),
          SizedBox(
            height:
                context.ResponsiveValu(20, mobile: 10, tablet: 30, desktop: 35),
          ),
          SignWithSocial(
            buttonLabel: StringEnums.sign_with_google.name,
            onPressed: () => onLoginWithGoogle(),
          )
        ],
      ),
    );
  }
}
