import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/entities/flavor.dart';
import '../../../domain/entities/offer.dart';
import '../../../domain/entities/product.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/flavor/flavor_bloc.dart';
import '../../bloc/offer/offer_bloc.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/question/question_bloc.dart';
import '../custom_dialog.dart';

class ProductCard extends StatelessWidget {
  final Product? product;
  const ProductCard({super.key, required this.product});

  void _flavorsQuestionsDialog(BuildContext context,
      {List<Offer> offers = const []}) {
    final MultiSelectController<Flavor> _flavorsController =
        MultiSelectController();
    final MultiSelectController<Product> _questionController =
        MultiSelectController();
    final TextEditingController _quantityController =
        TextEditingController(text: "1");
    final TextEditingController _noteController = TextEditingController();
    context.showCustomDialog(
        image: product!.icon,
        title: context.trValue(product!.proArName, product!.proEnName),
        onSubmit: () {
          List<Flavor> flavors = [];
          List<Product> questions = [];
          List<Offer> productOffers = [];
          try {
            flavors = _flavorsController.getSelectedItems();
          } catch (e) {
            debugPrint(e.toString());
          }
          try {
            questions = _questionController.getSelectedItems();
          } catch (e) {
            debugPrint(e.toString());
          }
          try {
            print(offers);
            productOffers = [
              ...offers.where((x) => x.productId == product!.proId).toList(),
              ...offers
                  .where((x) => questions.any((q) => x.productId == q.proId))
                  .toList()
            ];
            print(productOffers.length);
          } catch (e) {}
          context.read<CartBloc>().add(AddCartEvent(
                  cartItem: CartItem(
                product: product!,
                quantity: int.parse(_quantityController.text),
                flavors: flavors,
                questions: questions,
                note: _noteController.text,
                offers: productOffers,
              )));
        },
        child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<FlavorBloc>()),
              BlocProvider.value(value: context.read<QuestionBloc>()),
              BlocProvider.value(value: context.read<ProductBloc>()),
            ],
            child: CustomDialog(
              flavorsController: _flavorsController,
              questionController: _questionController,
              product: product,
              quantityController: _quantityController,
              noteController: _noteController,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferBloc, OfferState>(
      builder: (context, offerState) {
        final List<Offer> offers =
            offerState is OfferSuccess ? offerState.offers : [];
        final offer = product != null
            ? offers.firstWhereOrNull((x) => x.productId == product!.proId)
            : null;
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
                            darkenFactor: 0.2)
                        : null,
                    image: (product != null && product!.icon != null)
                        ? DecorationImage(
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).hintColor.withAlpha(10),
                              BlendMode.darken,
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
                            fontSize: context.AppResponsiveValue(14,
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
                                            fontSize:
                                                context.AppResponsiveValue(12,
                                                    mobile: 10,
                                                    tablet: 16,
                                                    desktop: 25),
                                          ),
                                      textAlign: TextAlign.start),
                                ],
                              ),
                            ),
                            IconButton.outlined(
                                iconSize: context.AppResponsiveValue(20,
                                    mobile: 15, tablet: 30, desktop: 40),
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    product != null
                                        ? context.generateColorFromValue(
                                            product!.catId.toString(),
                                            darkenFactor: 0.2)
                                        : Theme.of(context)
                                            .scaffoldBackgroundColor,
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
                                    ? () => _flavorsQuestionsDialog(context,
                                        offers: offers)
                                    : null,
                                icon: Icon(Icons.add))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (offer != null)
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    height: context.AppResponsiveValue(30,
                        mobile: 20, tablet: 40, desktop: 50),
                    decoration: BoxDecoration(color: Colors.red.withAlpha(225)),
                    child: Text(
                      context.trValue(offer.offerTypeAr, offer.offerTypeEn),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontSize: context.AppResponsiveValue(12,
                                mobile: 10, tablet: 16, desktop: 25),
                          ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
