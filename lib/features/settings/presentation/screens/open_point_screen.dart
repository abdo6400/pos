import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/entities/field.dart';
import '../../../../core/entities/form.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enums/field_type_enums.dart';
import '../../../../core/utils/enums/state_enums.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/global_form_builder/custom_form_builder.dart';
import '../../../../core/widgets/numeric_keypad_input.dart';
import '../bloc/open_point/open_point_bloc.dart';

class OpenPointScreen extends StatelessWidget {
  static GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OpenPointBloc, OpenPointState>(
      listener: (context, state) {
        if (state is OpenPointLoading) {
          context.showLottieOverlayLoader(Assets.loader);
        } else if (state is OpenPointSuccess) {
          context.go(AppRoutes.main);
        }else if(state is OpenPointFailure){
          context.handleState(StateEnum.error, state.error);
        }
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.loginBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              // appBar: AppBar(
              //   elevation: 2,
              //   centerTitle: true,
              //   title: Text(
              //     StringEnums.open_point.name.tr(),
              //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
              //           fontSize: context.AppResponsiveValue(18,
              //               mobile: 12, tablet: 24, desktop: 30),
              //         ),
              //   ),
              // ),
              body: Center(
                child: Container(
                    width: context.AppResponsiveValue(400,
                        mobile: 300, tablet: 900, desktop: 800),
                    padding: EdgeInsets.symmetric(
                        horizontal: context.AppResponsiveValue(20,
                            mobile: 12, tablet: 70, desktop: 30)),
                    child: Card(
                      elevation: 2,
                      color: Colors.white54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 20,
                          children: [
                            Card(
                              elevation: 0.1,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                   mainAxisSize: MainAxisSize.min,
                                   spacing: 20,
                                  children: [
                                    Icon(Icons.point_of_sale,color: Theme.of(context).colorScheme.primary,),
                                    Text(
                                      StringEnums.open_point.name.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: context.AppResponsiveValue(18,
                                                mobile: 12, tablet: 24, desktop: 30),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CustomFormBuilder(
                              FormParams(formKey: _formKey, fields: [
                                FieldParams(
                                  type: FieldTypeEnums.text,
                                  label: StringEnums.amount.name,
                                  validators: [
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.positiveNumber(),
                                  ],
                                  icon: Icons.money_outlined,
                                ),
                              ]),
                            ),
                            NumericKeypadInput(
                              formKey: _formKey,
                            ),
                            CustomButton(
                              onSubmit: () {
                                if (_formKey.currentState?.saveAndValidate() ??
                                    false) {
                                  context.read<OpenPointBloc>().add(
                                      OpenPointRequested(
                                          cashCustody: double.tryParse(_formKey
                                                  .currentState
                                                  ?.fields[
                                                      StringEnums.amount.name]
                                                  ?.value) ??
                                              0));
                                }
                              },
                              buttonLabel: StringEnums.open_point.name.tr(),
                            ),
                          ],
                        ),
                      ),
                    )),
              )),
        );
      },
    );
  }
}
