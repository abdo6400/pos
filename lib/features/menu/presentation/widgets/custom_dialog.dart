import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:retail/features/menu/presentation/widgets/flavors_list.dart';
import '../../../../core/utils/enums/string_enums.dart';
import '../../domain/entities/flavor.dart';
import '../../domain/entities/product.dart';
import 'questions_list.dart';

class CustomDialog extends StatelessWidget {
  final MultiSelectController<Flavor> flavorsController;
  final MultiSelectController<Product> questionController;
  final TextEditingController noteController;
  final TextEditingController quantityController;
  final Product? product;
  final List<Flavor> selectedFlavors;
  final List<Product> selectedQuestions;

  const CustomDialog(
      {super.key,
      required this.flavorsController,
      required this.questionController,
      required this.product,
      this.selectedFlavors = const [],
      this.selectedQuestions = const [],
      required this.noteController,
      required this.quantityController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.AppResponsiveValue(400,
          mobile: 300, tablet: 500, desktop: 800),
      child: Row(
        children: [
          Flexible(
              child: FlavorsList(
            catId: product!.catId,
            controller: flavorsController,
            selectedFlavors: selectedFlavors,
          )),
          const VerticalDivider(),
          Flexible(
              child: QuestionsList(
            productId: product!.proId,
            controller: questionController,
            selectedQuestions: selectedQuestions,
          )),
          const VerticalDivider(),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(StringEnums.note.name.tr(),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: context.AppResponsiveValue(16,
                                mobile: 12, tablet: 24, desktop: 30))),
                    TextFormField(
                        controller: noteController,
                        maxLines: 10,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: context.AppResponsiveValue(16,
                                mobile: 12, tablet: 20, desktop: 30)),
                        decoration: InputDecoration(
                          hintText: StringEnums.add_note.name.tr(),
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: context.AppResponsiveValue(16,
                                        mobile: 12, tablet: 24, desktop: 30),
                                  ),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                        )),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(StringEnums.quentity.name.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: context.AppResponsiveValue(16,
                                      mobile: 12, tablet: 24, desktop: 30))),
                    ),
                    Flexible(
                      flex: context.AppResponsiveValue(2,
                              mobile: 2, tablet: 1, desktop: 1)
                          .toInt(),
                      child: Row(
                        children: [
                          IconButton.outlined(
                              onPressed: () {
                                quantityController.text =
                                    (int.parse(quantityController.text) + 1)
                                        .toString();
                              },
                              icon: Icon(Icons.add)),
                          Expanded(
                            child: TextField(
                              controller: quantityController,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: context.AppResponsiveValue(16,
                                          mobile: 12, tablet: 24, desktop: 30)),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          IconButton.outlined(
                              onPressed: () {
                                if (quantityController.text == "1") return;
                                quantityController.text =
                                    (int.parse(quantityController.text) - 1)
                                        .toString();
                              },
                              icon: Icon(Icons.remove))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
