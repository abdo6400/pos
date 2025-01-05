import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:retail/core/utils/extensions/extensions.dart';

import '../../domain/entities/flavor.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/question.dart';
import '../bloc/flavor/flavor_bloc.dart';
import '../bloc/question/question_bloc.dart';
import 'flavors_list.dart';
import 'questions_list.dart';

class ProductCard extends StatelessWidget {
  final Product? product;
  const ProductCard({super.key, required this.product});
  static final MultiSelectController<Flavor> _flavorsController =
      MultiSelectController();
  static final MultiSelectController<Question> _questionController =
      MultiSelectController();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: product != null
              ? context
                  .generateColorFromValue(product!.catId.toString(),
                      darkenFactor: 0.2)
                  .withAlpha(120)
              : Colors.grey,
        ),
        borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            bottomStart: Radius.circular(15),
            topEnd: Radius.circular(15),
            topStart: Radius.circular(10)),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            image: (product != null && product!.icon != null)
                ? DecorationImage(
                    image: context.displayBase64Image(product!.icon!))
                : null),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      product != null
                          ? context.trValue(
                              product!.proArName, product!.proEnName)
                          : "Product ",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: context.ResponsiveValu(12,
                                mobile: 10, tablet: 16, desktop: 25),
                          ),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product != null ? product!.price.toString() : "0.00",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: context.ResponsiveValu(14,
                            mobile: 10, tablet: 20, desktop: 24),
                      ),
                ),
                IconButton.outlined(
                    iconSize: context.ResponsiveValu(20,
                        mobile: 15, tablet: 30, desktop: 40),
                    onPressed: product == null
                        ? null
                        : () => context.showCustomDialog(
                            onSubmit: () {
                              _flavorsController.getSelectedItems();
                              _questionController.getSelectedItems();
                            },
                            child: MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                      value: context.read<FlavorBloc>()),
                                  BlocProvider.value(
                                      value: context.read<QuestionBloc>()),
                                ],
                                child: SizedBox(
                                  height: context.ResponsiveValu(400,
                                      mobile: 300, tablet: 500, desktop: 600),
                                  child: Row(
                                    children: [
                                      Flexible(
                                          child: FlavorsList(
                                        catId: product!.catId,
                                        controller: _flavorsController,
                                      )),
                                      Flexible(
                                          child: QuestionsList(
                                        productId: product!.proId,
                                        controller: _questionController,
                                      )),
                                    ],
                                  ),
                                ))),
                    icon: Icon(Icons.add)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
