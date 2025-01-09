import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../../../core/widgets/empty_message.dart';
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

class CartList extends StatelessWidget {
  const CartList({super.key});
  void _flavorsQuestionsDialog(BuildContext context, CartItem cartItem,
      {List<Offer> offers = const []}) {
    final MultiSelectController<Flavor> _flavorsController =
        MultiSelectController();
    final MultiSelectController<Product> _questionController =
        MultiSelectController();
    final TextEditingController _quantityController =
        TextEditingController(text: cartItem.quantity.toString());
    final TextEditingController _noteController =
        TextEditingController(text: cartItem.note);
    context.showCustomDialog(
        image: cartItem.product.icon,
        title: context.trValue(
            cartItem.product.proArName, cartItem.product.proEnName),
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
            productOffers = [
              ...offers
                  .where((x) => x.productId == cartItem.product.proId)
                  .toList(),
              ...offers
                  .where((x) => questions.any((q) => x.productId == q.proId))
                  .toList()
            ];
          } catch (e) {}
          context.read<CartBloc>().add(UpdateCartEvent(
                  cartItem: CartItem(
                product: cartItem.product,
                note: _noteController.text,
                quantity: int.parse(_quantityController.text),
                flavors: flavors,
                questions: questions,
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
              selectedFlavors: cartItem.flavors,
              selectedQuestions: cartItem.questions,
              flavorsController: _flavorsController,
              questionController: _questionController,
              product: cartItem.product,
              quantityController: _quantityController,
              noteController: _noteController,
            )));
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: context.AppResponsiveValue(12,
            mobile: 10, tablet: 16, desktop: 25));
    return BlocBuilder<OfferBloc, OfferState>(
      builder: (context, offerState) {
        return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state.cart.isEmpty) {
            return EmptyMessage(
              message: StringEnums.empty_cart.name.tr(),
            );
          }
          return ListView.builder(
            itemCount: state.cart.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(state.cart[index].product.proId),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: AlignmentDirectional.centerEnd,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: context.AppResponsiveValue(30,
                        mobile: 20, tablet: 35, desktop: 40),
                  ),
                ),
                onDismissed: (_) => context.read<CartBloc>().add(
                      DeleteCartEvent(
                        productId: state.cart[index].product.proId,
                      ),
                    ),
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: state.cart[index].product.icon != null
                            ? CachedNetworkImage(
                                fit: BoxFit.fill,
                                width: context.AppResponsiveValue(50,
                                    mobile: 40, tablet: 80, desktop: 100),
                                height: context.AppResponsiveValue(50,
                                    mobile: 40, tablet: 80, desktop: 100),
                                imageUrl: state.cart[index].product.icon!,
                                errorWidget: (context, url, error) => Container(
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                    color: context.generateColorFromValue(
                                      state.cart[index].product.proId,
                                    )),
                              )
                            : null,
                        title: Text(
                          state.cart[index].product.proEnName,
                          style: style,
                        ),
                        subtitle: Text(
                            state.cart[index].product.price.toString(),
                            style: style),
                        trailing:
                            Text('${state.cart[index].quantity}', style: style),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Colors.green,
                      ),
                      onPressed: () => _flavorsQuestionsDialog(
                          context, state.cart[index],
                          offers: offerState is OfferSuccess
                              ? offerState.offers
                              : []),
                    ),
                  ],
                ),
              );
            },
          );
        });
      },
    );
  }
}
