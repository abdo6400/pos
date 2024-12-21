import '../../../../../core/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../bloc/login/login_bloc.dart';
import '../components/custom_app_bar.dart';
import '../components/custom_bottom_bar.dart';
import '../components/custom_top_bar.dart';
import '../components/login_components/login_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => locator<LoginBloc>(),
        child: Scaffold(
          body: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is LoginSuccess) {
                await storage.saveAuthTokenState(
                    state.tokens.accessToken, state.tokens.refreshToken);
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
            builder: (context, state) => Column(
              children: [
                Expanded(flex: 1, child: CustomAppBar()),
                Expanded(
                  flex: 5,
                  child: CustomTopBar(
                    title: StringEnums.login.name,
                    image: Assets.login,
                    message: StringEnums.appMessage.name,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: LoginFormBuilder(
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
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomBar(
            title: StringEnums.no_account.name,
            subTitle: StringEnums.sign_up.name,
            route: AppRoutes.register,
          ),
        ),
      ),
    );
  }
}
