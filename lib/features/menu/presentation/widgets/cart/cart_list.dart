import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../../../core/widgets/empty_message.dart';
import '../../../domain/entities/flavor.dart';
import '../../../domain/entities/offer.dart';
import '../../../domain/entities/product.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_item.dart';
import '../../bloc/cubit/delivery_selection_cubit.dart';
import '../../bloc/flavor/flavor_bloc.dart';
import '../../bloc/offer/offer_bloc.dart';
import '../../bloc/order/order_bloc.dart';
import '../../bloc/order/order_item.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/question/question_bloc.dart';
import '../custom_dialog.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});
  void _flavorsQuestionsDialog(BuildContext context, CartItem cartItem,
      {List<Offer> offers = const []}) {
    final MultiSelectController<Flavor> _flavorsController =
        MultiSelectController();
    final MultiSelectController<dynamic> _questionController =
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
            questions = _questionController.getSelectedItems().cast<Product>();
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
                  id: cartItem.id,
                  product: cartItem.product,
                  note: _noteController.text,
                  quantity: int.parse(_quantityController.text),
                  flavors: flavors,
                  questions: questions,
                  offers: productOffers,
                  isOffer: cartItem.isOffer,
                  extraItemId: cartItem.extraItemId,
                  orignialPrice: cartItem.orignialPrice)));
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
        fontSize:
            context.AppResponsiveValue(9, mobile: 9, tablet: 16, desktop: 18));
    return BlocBuilder<OfferBloc, OfferState>(
      builder: (context, offerState) {
        return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state.cart.isEmpty) {
            return EmptyMessage(
              message: StringEnums.empty_cart.name.tr(),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.cart.length,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: ValueKey(state.cart[index].id),
                      direction: state.cart[index].isOffer
                          ? DismissDirection.none
                          : DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: AlignmentDirectional.centerEnd,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: context.AppResponsiveValue(25,
                              mobile: 20, tablet: 30, desktop: 35),
                        ),
                      ),
                      onDismissed: (_) => context.read<CartBloc>().add(
                            DeleteCartEvent(
                              productId: state.cart[index].id,
                            ),
                          ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Badge.count(
                              alignment: AlignmentDirectional(-0.95, -0.8),
                              count: state.cart[index].quantity,
                              backgroundColor:
                                  Theme.of(context).primaryColor.withAlpha(225),
                              textColor: Colors.white,
                              textStyle: style.copyWith(
                                color: Colors.white,
                                fontSize: context.AppResponsiveValue(10,
                                    mobile: 10, tablet: 16, desktop: 20),
                              ),
                              padding: EdgeInsets.all(3),
                              child: ListTile(
                                leading: state.cart[index].isOffer
                                    ? Image.asset(
                                        Assets.offer,
                                        fit: BoxFit.fill,
                                        width: context.AppResponsiveValue(40,
                                            mobile: 40,
                                            tablet: 80,
                                            desktop: 100),
                                        height: context.AppResponsiveValue(40,
                                            mobile: 40,
                                            tablet: 80,
                                            desktop: 100),
                                      )
                                    : (state.cart[index].product.icon != null
                                        ? CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            width: context.AppResponsiveValue(
                                                50,
                                                mobile: 40,
                                                tablet: 80,
                                                desktop: 100),
                                            height: context.AppResponsiveValue(
                                                50,
                                                mobile: 40,
                                                tablet: 80,
                                                desktop: 100),
                                            imageUrl:
                                                state.cart[index].product.icon!,
                                            errorWidget: (context, url,
                                                    error) =>
                                                Container(
                                                    child: Icon(
                                                      Icons.image,
                                                      color: Colors.white,
                                                    ),
                                                    color: context
                                                        .generateColorFromValue(
                                                      state.cart[index].product
                                                          .proId,
                                                    )),
                                          )
                                        : null),
                                title: Text(
                                  state.cart[index].product.proEnName,
                                  style: style,
                                ),
                                subtitle: Text(
                                  '${state.cart[index].flavors.map((x) => context.trValue(x.flavorAr, x.flavorEn)).join(', ') + " , " + state.cart[index].questions.map((x) => context.trValue(x.proArName, x.proEnName)).join(', ')}',
                                  style: style,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: state.cart[index].isOffer
                                    ? null
                                    : BlocBuilder<DeliverySelectionCubit,
                                        DeliveryWithDiscount?>(
                                        builder: (context, delivery) {
                                          return Text(
                                              (delivery?.getPrice(
                                                          state.cart[index]
                                                              .product.price,
                                                          state.cart[index]
                                                              .product.price2,
                                                          state.cart[index]
                                                              .product.price3,
                                                          state
                                                              .cart[index]
                                                              .product
                                                              .price4) ??
                                                      state.cart[index].product
                                                          .price)
                                                  .toString(),
                                              style: style);
                                        },
                                      ),
                              ),
                            ),
                          ),
                          if (!state.cart[index].isOffer)
                            IconButton(
                              icon: Icon(
                                Icons.edit_outlined,
                                color: Colors.green,
                                size: context.AppResponsiveValue(20,
                                    mobile: 20, tablet: 30, desktop: 35),
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
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                    onPressed: () {
                      context.read<OrderBloc>().add(AddOrderEvent(OrderItem(
                          orderId: Uuid().v4(),
                          orderDate: DateTime.now().toIso8601String(),
                          orderStatus: 'Pending',
                          cartItems: state.cart)));
                      context.read<CartBloc>().add(ClearCartEvent());
                    },
                    icon: Row(
                      children: [
                        Icon(
                          Icons.add_outlined,
                          color: Colors.yellow,
                          size: context.AppResponsiveValue(25,
                              mobile: 25, tablet: 30, desktop: 35),
                        ),
                        Text(StringEnums.pending.name.tr(), style: style),
                      ],
                    )),
                IconButton(
                    onPressed: () =>
                        context.read<CartBloc>().add(ClearCartEvent()),
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: context.AppResponsiveValue(25,
                          mobile: 25, tablet: 30, desktop: 35),
                    ))
              ]),
            ],
          );
        });
      },
    );
  }
}
