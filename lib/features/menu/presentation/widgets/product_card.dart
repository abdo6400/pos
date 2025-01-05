import 'package:cached_network_image/cached_network_image.dart';
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

  void _flavorsQuestionsDialog(BuildContext context) {
    final MultiSelectController<Flavor> _flavorsController =
        MultiSelectController();
    final MultiSelectController<Question> _questionController =
        MultiSelectController();
    context.showCustomDialog(
      image: product!.icon,
      title: context.trValue(product!.proArName, product!.proEnName),
      onSubmit: () {
        _flavorsController.getSelectedItems();
        _questionController.getSelectedItems();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<FlavorBloc>()),
          BlocProvider.value(value: context.read<QuestionBloc>()),
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
              const VerticalDivider(),
              Flexible(
                  child: QuestionsList(
                productId: product!.proId,
                controller: _questionController,
              )),
            ],
          ),
        ),
      ),
    );
  }

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
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10),
                    bottomStart: Radius.circular(15),
                    topEnd: Radius.circular(15),
                    topStart: Radius.circular(10)),
                color: product != null
                    ? context.generateColorFromValue(product?.catId ?? "0",
                        darkenFactor: 0.5)
                    : null,
                image: (product != null && product!.icon != null)
                    ? DecorationImage(
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).primaryColor.withAlpha(220),
                          BlendMode.modulate,
                        ),
                        image: CachedNetworkImageProvider(product!.icon!),
                        fit: BoxFit.fill)
                    : null),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Card(
              margin: EdgeInsets.all(0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10),
                    bottomStart: Radius.circular(15),
                    topEnd: Radius.circular(15),
                    topStart: Radius.circular(10)),
              ),
              color: Theme.of(context).cardColor.withAlpha(220),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product != null ? product!.price.toString() : "0.00",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: context.ResponsiveValu(14,
                            mobile: 10, tablet: 20, desktop: 24),
                      ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  margin: EdgeInsets.all(0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(10),
                        bottomStart: Radius.circular(15),
                        topEnd: Radius.circular(15),
                        topStart: Radius.circular(10)),
                  ),
                  color: Theme.of(context).cardColor.withAlpha(220),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                  product != null
                                      ? context.trValue(product!.proArName,
                                          product!.proEnName)
                                      : "Product ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: context.ResponsiveValu(12,
                                            mobile: 10,
                                            tablet: 16,
                                            desktop: 25),
                                      ),
                                  textAlign: TextAlign.start),
                            ],
                          ),
                        ),
                        IconButton.outlined(
                            iconSize: context.ResponsiveValu(20,
                                mobile: 15, tablet: 30, desktop: 40),
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                product != null
                                    ? context.generateColorFromValue(
                                        product!.catId.toString(),
                                        darkenFactor: 0.2)
                                    : Theme.of(context).scaffoldBackgroundColor,
                              ),
                              iconColor: WidgetStatePropertyAll(
                                Colors.white,
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            onPressed: product != null
                                ? () => _flavorsQuestionsDialog(context)
                                : null,
                            icon: Icon(Icons.add)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
