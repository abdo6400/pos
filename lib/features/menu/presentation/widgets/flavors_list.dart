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
  const FlavorsList({super.key, required this.catId, required this.controller});

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  StringEnums.flavors.name.tr(),
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
                                  title: Text(context.trValue(
                                      flavors[index].flavorAr,
                                      flavors[index].flavorEn)),
                                  textStyles: MultiSelectItemTextStyles(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  subtitle:
                                      Text(flavors[index].price.toString()),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                )),
                        onChange: (allSelectedItems, selectedItem) {},
                        onMaximumSelected: (allSelectedItems, selectedItem) {},
                      )
                    : Container(),
              )
            ],
          ));
    });
  }
}
