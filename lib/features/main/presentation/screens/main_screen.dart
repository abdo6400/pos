import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/floating_menu/animated_rail.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../../../core/utils/extensions/extensions.dart';
import '../../../menu/presentation/bloc/category/category_bloc.dart';
import '../../../menu/presentation/bloc/product/product_bloc.dart';
import '../../../settings/presentation/screens/settings_screen.dart';
import '../bloc/cubit/screen_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ScreenCubit(),
        ),
        BlocProvider(
          create: (context) =>
              locator<CategoryBloc>()..add(GetCategoriesEvent()),
        ),
        BlocProvider(
          create: (context) => locator<ProductBloc>(),
        ),
      ],
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocBuilder<ScreenCubit, int>(
            builder: (context, index) {
              return Stack(
                children: [
                  [HomeScreen(), SettingsScreen()][index],
                  AnimatedRail(
                    direction: Directionality.of(context),
                    maxWidth: context.ResponsiveValu(50,
                        mobile: 45, tablet: 60, desktop: 100, large: 250),
                    width: context.ResponsiveValu(50,
                        mobile: 45, tablet: 60, desktop: 100, large: 250),
                    cursorSize: Size(
                      context.ResponsiveValu(60,
                          mobile: 50, tablet: 80, desktop: 130, large: 140),
                      context.ResponsiveValu(60,
                          mobile: 50, tablet: 80, desktop: 130, large: 140),
                    ),
                    expand: false,
                    isStatic: false,
                    onChange: (value) {
                      context.read<ScreenCubit>().changeScreen(value);
                    },
                    background: Theme.of(context).textTheme.bodyLarge!.color,
                    railTileConfig: RailTileConfig(
                      iconSize: context.ResponsiveValu(35,
                          mobile: 30, tablet: 40, desktop: 60, large: 70),
                      iconColor: Theme.of(context).scaffoldBackgroundColor,
                      activeColor: Theme.of(context).colorScheme.secondary,
                      hideCollapsedText: true,
                    ),
                    items: [
                      RailItem(
                        icon: Icon(Icons.home),
                        label: "Home",
                      ),
                      RailItem(
                        icon: Icon(Icons.message_outlined),
                        label: 'Settings',
                      ),
                    ],
                  ),
                ],
              );
            },
          )),
    );
  }
}
