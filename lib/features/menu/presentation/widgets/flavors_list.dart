import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../../../core/widgets/empty_message.dart';
import '../../../../core/widgets/errors/error_card.dart';
import '../../domain/entities/flavor.dart';
import '../bloc/flavor/flavor_bloc.dart';

class FlavorsList extends StatelessWidget {
  final String catId;
  final MultiSelectController<Flavor> controller;
  final List<Flavor> selectedFlavors;
  const FlavorsList(
      {super.key,
      required this.catId,
      required this.controller,
      this.selectedFlavors = const []});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: context.AppResponsiveValue(16,
              mobile: 14, tablet: 20, desktop: 25),
        );
    return BlocBuilder<FlavorBloc, FlavorState>(builder: (context, state) {
      if (state is FlavorError) {
        return ErrorCard(
          message: state.message,
          onRetry: () => context.read<FlavorBloc>().add(GetFlavorsEvent()),
        );
      }
      final List<Flavor> flavors =
          state is FlavorSuccess ? state.filteredFlavorsByCategory(catId) : [];
      if (state is FlavorSuccess && flavors.isEmpty) {
        return Center(
          child: EmptyMessage(
            message: StringEnums.no_flavors_found.name.tr(),
          ),
        );
      }
      return Skeletonizer(
          enabled: state is FlavorLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).scaffoldBackgroundColor.withAlpha(225),
                ),
                child: Row(
                  spacing: 10,
                  children: [
                    const Icon(
                      Icons.fastfood_outlined,
                      color: Colors.deepOrange,
                    ),
                    Text(
                      StringEnums.flavors.name.tr(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: context.AppResponsiveValue(16,
                                mobile: 14, tablet: 20, desktop: 25),
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: state is FlavorSuccess
                    ? MultiSelectCheckList<Flavor>(
                        maxSelectableCount: flavors.length,
                        listViewSettings: ListViewSettings(
                            separatorBuilder: (context, index) => const Divider(
                                  height: 0,
                                )),
                        controller: controller,
                        items: List.generate(
                            flavors.length,
                            (index) => CheckListCard(
                                  value: flavors[index],
                                  selected: selectedFlavors.contains(
                                    flavors[index],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  title: Text(context.trValue(
                                      flavors[index].flavorAr,
                                      flavors[index].flavorEn)),
                                  subtitle: Text(
                                    "${flavors[index].price}",
                                    style: style,
                                  ),
                                  leadingCheckBox: false,
                                  textStyles: MultiSelectItemTextStyles(
                                      selectedTextStyle: style,
                                      disabledTextStyle: style,
                                      textStyle: style),
                                )),
                        onChange: (allSelectedItems, selectedItem) {},
                      )
                    : Card(),
              )
            ],
          ));
    });
  }
}
