import '../../../../../core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../bloc/login/login_bloc.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/login_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => locator<LoginBloc>(),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.loginBackground),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: context.AppResponsiveValue(300,
                        mobile: 200, tablet: 500, desktop: 600),
                    child: BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) async {
                        if (state is LoginSuccess) {
                          await storage.saveAuthTokenState(
                              state.tokens.token, state.tokens.toJson());
                          _formKey.currentState?.reset();
                          context.hideOverlayLoader();
                          context.pushReplacement(AppRoutes.main);
                        } else if (state is LoginError) {
                          context.hideOverlayLoader();
                          context.showMessageToast(msg: state.message);
                        } else if (state is LoginLoading) {
                          context.showLottieOverlayLoader(Assets.loader);
                        }
                      },
                      builder: (context, state) => LoginFormBuilder(
                        formKey: _formKey,
                        onSubmit: () async => context.read<LoginBloc>().add(
                              LoginEvent(
                                email: _formKey.currentState
                                    ?.fields[StringEnums.email.name]?.value,
                                password: _formKey.currentState
                                    ?.fields[StringEnums.password.name]?.value,
                              ),
                            ),
                        onReset: () {},
                        onLoginWithGoogle: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ),
            CustomAppBar(),
          ],
        ),
      ),
    );
  }
}
