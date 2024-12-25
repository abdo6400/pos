import '../../../../../core/utils/extensions/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/utils/enums/string_enums.dart';
import 'custom_sign_button.dart';

class OtpDialog extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey;
  final VoidCallback onSubmit;
  final void Function()? onResendOtp;
  const OtpDialog(
      {super.key,
      required GlobalKey<FormBuilderState> formKey,
      required this.onSubmit,
      required this.onResendOtp})
      : _formKey = formKey;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      margin: EdgeInsetsDirectional.only(
        end: context.ResponsiveValu(5, mobile: 5, tablet: 20, desktop: 30),
      ),
      width: context.ResponsiveValu(45, mobile: 30, tablet: 60, desktop: 100),
      height: context.ResponsiveValu(45, mobile: 30, tablet: 60, desktop: 100),
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Theme.of(context).colorScheme.secondary),
      borderRadius: BorderRadius.circular(5),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
      ),
    );
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal:
              context.ResponsiveValu(10, mobile: 5, tablet: 30, desktop: 100),
          vertical:
              context.ResponsiveValu(20, mobile: 10, tablet: 80, desktop: 100),
        ),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringEnums.otp_heading.name.tr(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: context.ResponsiveValu(16,
                          mobile: 14, tablet: 20, desktop: 24),
                    ),
              ),
              SizedBox(height: 10),
              Text(
                StringEnums.otp_description.name.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: context.ResponsiveValu(12,
                          mobile: 10, tablet: 18, desktop: 20),
                    ),
              ),
              SizedBox(height: 50),
              FormBuilderField(
                name: StringEnums.otp_heading.name,
                builder: (field) => Pinput(
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: StringEnums.please_enter_otp.name.tr()),
                    FormBuilderValidators.equalLength(6,
                        errorText: StringEnums.otp_length_error.name.tr()),
                  ]),
                  length: 6,
                  pinAnimationType: PinAnimationType.slide,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  onChanged: (value) => field.didChange(value),
                ),
              ),
              SizedBox(height: 40),
              CustomSignButton(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                onSubmit: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    onSubmit();
                  }
                },
                buttonLabel: StringEnums.otp_verify.name,
              ),
              SizedBox(height: 20),
              Text(
                StringEnums.resend_otp.name.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: context.ResponsiveValu(12,
                          mobile: 10, tablet: 18, desktop: 20),
                    ),
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: onResendOtp,
                child: Text(
                  StringEnums.resend_otp.name.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).primaryColor,
                        fontSize: context.ResponsiveValu(10,
                            mobile: 10, tablet: 18, desktop: 20),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
