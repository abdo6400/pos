import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../bloc/open_point/open_point_bloc.dart';

class OpenPointScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OpenPointBloc, OpenPointState>(
      listener: (context, state) {
        if (state is OpenPointLoading) {
          context.showLottieOverlayLoader(Assets.loader);
        }
        else if (state is OpenPointSuccess) {
          context.go(AppRoutes.main);
        }
      }
        ,
          builder: (context, state) {
            return Scaffold(
            appBar: AppBar(
              title: Text(StringEnums.open_point.name.tr()),
            ),
            body: Center(
              child: Column( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<OpenPointBloc>().add(OpenPointRequested(cashCustody: 1.0));// call open point api
                    },
                    child: Text(StringEnums.open_point.name.tr()),
                  ),
                ],
              )
            ));
      },
    );
  }
}
