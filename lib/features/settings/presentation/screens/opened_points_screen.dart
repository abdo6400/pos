import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retail/core/utils/assets.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/enums/state_enums.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/custom_button.dart';
import '../bloc/end_day/end_day_bloc.dart';
import '../bloc/opened_point/opened_points_bloc.dart';

class OpenedPointsScreen extends StatelessWidget {
  const OpenedPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final mustCloseDay = data['mustCloseDay'] as bool;
    return PopScope(
      canPop: !mustCloseDay,
      onPopInvokedWithResult: (value, _) {
        if (!mustCloseDay) {
          context.go(AppRoutes.main);
        }
      },
      child: BlocConsumer<EndDayBloc, EndDayState>(
        listener: (context, state) {
          if (state is EndDaySuccess) {
            context.go(AppRoutes.login);
          } else if (state is EndDayFailure) {
            context.handleState(StateEnum.error, state.error);
          } else if (state is EndDayLoading) {
            context.showLottieOverlayLoader(Assets.loader);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              title: Text(StringEnums.openedPoints.name.tr()),
              centerTitle: true,
              leading: (!mustCloseDay)
                  ? IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context.go(AppRoutes.main);
                      },
                    )
                  : null,
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                if ((!mustCloseDay))
                  Flexible(
                    child: CustomButton(
                      buttonLabel: StringEnums.close.name.tr(),
                      backgroundColor: Colors.red,
                      onSubmit: () {
                        context.go(AppRoutes.main);
                      },
                    ),
                  ),
                Flexible(
                  child: CustomButton(
                    buttonLabel: StringEnums.shift_end.name.tr(),
                    onSubmit: () {
                      context.read<EndDayBloc>().add(EndDayRequested(
                            lineDate:
                                data[StringEnums.from_date.name] as String,
                            closeTime: data[StringEnums.to_date.name] as String,
                          ));
                    },
                  ),
                )
              ]),
            ),
            body: BlocBuilder<OpenedPointsBloc, OpenedPointsState>(
              builder: (context, state) {
                if (state is OpenedPointsSuccess) {
                  return ListView.builder(
                    itemCount: state.openedPoints.length,
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      final openedPoint = state.openedPoints[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.payment),
                          title: Text(openedPoint.cashNo.toString()),
                          subtitle: Text(openedPoint.cashUser.toString()),
                          trailing: IconButton.outlined(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            icon: Text(StringEnums.close_cash.name.tr(),
                                style: const TextStyle(color: Colors.white)),
                            onPressed: () {
                              context.push(AppRoutes.closeCashbox,
                                  extra: {
                                    StringEnums.open_point.name: openedPoint.cashUser,
                                    StringEnums.close_cash.name: openedPoint.cashNo,
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is OpenedPointsFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
