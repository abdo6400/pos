import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../../core/utils/assets.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onEdit;
  final bool isOffer;
  final double? price;
  late final TextEditingController _quantityController;
  CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.onEdit,
    this.isOffer = false,
    this.price,
  }) : super(key: key) {
    _quantityController =
        TextEditingController(text: cartItem.quantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.bodyMedium!.copyWith(
      fontSize:
          context.AppResponsiveValue(8, mobile: 8, tablet: 12, desktop: 18),
      fontWeight: FontWeight.w500,
    );
    final subtitleStyle = textTheme.bodySmall!.copyWith(
      fontSize:
          context.AppResponsiveValue(8, mobile: 8, tablet: 11, desktop: 16),
      color: Colors.black54,
    );
    final priceStyle = textTheme.bodyMedium!.copyWith(
      fontSize:
          context.AppResponsiveValue(10, mobile: 10, tablet: 16, desktop: 18),
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
    );

    return Card(
      elevation: 0.1,
      margin: EdgeInsets.symmetric(
        vertical:
            context.AppResponsiveValue(4, mobile: 4, tablet: 6, desktop: 8),
        horizontal:
            context.AppResponsiveValue(4, mobile: 4, tablet: 6, desktop: 8),
      ),
      child: Padding(
        padding: EdgeInsets.all(
            context.AppResponsiveValue(4, mobile: 4, tablet: 6, desktop: 8)),
        child: Row(
          children: [
            // Product image with quantity badge
            Badge.count(
              alignment: AlignmentDirectional(-1.2, -1),
              count: cartItem.quantity,
              backgroundColor: Theme.of(context).primaryColor.withAlpha(225),
              textColor: Colors.white,
              textStyle: titleStyle.copyWith(
                color: Colors.white,
                fontSize: context.AppResponsiveValue(9,
                    mobile: 9, tablet: 14, desktop: 18),
              ),
              padding: EdgeInsets.all(context.AppResponsiveValue(3,
                  mobile: 3, tablet: 4, desktop: 5)),
              child: _buildProductImage(context),
            ),

            SizedBox(
                width: context.AppResponsiveValue(8,
                    mobile: 8, tablet: 12, desktop: 16)),

            // Product details
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    cartItem.product.proEnName,
                    style: titleStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (cartItem.flavors.isNotEmpty ||
                      cartItem.questions.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.AppResponsiveValue(2,
                              mobile: 2, tablet: 4, desktop: 6)),
                      child: Text(
                        '${cartItem.flavors.map((x) => context.trValue(x.flavorAr, x.flavorEn)).join(', ')}${cartItem.flavors.isNotEmpty && cartItem.questions.isNotEmpty ? " , " : ""}${cartItem.questions.map((x) => context.trValue(x.proArName, x.proEnName)).join(', ')}',
                        style: subtitleStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),

            // Price
            if (!isOffer && price != null)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.AppResponsiveValue(4,
                        mobile: 4, tablet: 8, desktop: 12)),
                child: Text(
                  price.toString(),
                  style: priceStyle,
                ),
              ),
 Column(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<CartBloc>().add(UpdateCartEvent(
                            cartItem: cartItem.copyWith(
                          quantity: int.parse(_quantityController.text) + 1,
                        )));
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Theme.of(context).colorScheme.secondary,
                    size: context.AppResponsiveValue(20,
                        mobile: 20, tablet: 30, desktop: 35),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (int.parse(_quantityController.text) > 1)
                      context.read<CartBloc>().add(UpdateCartEvent(
                              cartItem: cartItem.copyWith(
                            quantity: int.parse(_quantityController.text) - 1,
                          )));
                    },
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: Theme.of(context).colorScheme.secondary,
                      size: context.AppResponsiveValue(20,
                          mobile: 20, tablet: 30, desktop: 35),
                    ))
              ],
            ),
            // Edit button
            if (!isOffer)
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: Colors.green,
                  size: context.AppResponsiveValue(20,
                      mobile: 20, tablet: 30, desktop: 35),
                ),
                onPressed: onEdit,
                padding: EdgeInsets.all(context.AppResponsiveValue(4,
                    mobile: 4, tablet: 6, desktop: 8)),
                constraints: BoxConstraints(),
              ),
           
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    final imageSize =
        context.AppResponsiveValue(45, mobile: 45, tablet: 60, desktop: 90);

    if (isOffer) {
      return Image.asset(
        Assets.offer,
        fit: BoxFit.contain,
        width: imageSize,
        height: imageSize,
      );
    } else if (cartItem.product.icon != null) {
      return CachedNetworkImage(
        fit: BoxFit.cover,
        width: imageSize,
        height: imageSize,
        imageUrl: cartItem.product.icon!,
        errorWidget: (context, url, error) => Container(
          width: imageSize,
          height: imageSize,
          color: context.generateColorFromValue(cartItem.product.proId),
          child: Icon(
            Icons.image,
            color: Colors.white,
            size: imageSize * 0.5,
          ),
        ),
      );
    } else {
      return Container(
        width: imageSize,
        height: imageSize,
        color: context.generateColorFromValue(cartItem.product.proId),
        child: Icon(
          Icons.image,
          color: Colors.white,
          size: imageSize * 0.5,
        ),
      );
    }
  }
}
