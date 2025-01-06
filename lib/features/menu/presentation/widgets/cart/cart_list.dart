import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import '../../../../../core/utils/enums/string_enums.dart';
import '../../../../../core/widgets/empty_message.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/entities/flavor.dart';
import '../../../domain/entities/question.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/flavor/flavor_bloc.dart';
import '../../bloc/question/question_bloc.dart';
import '../flavors_list.dart';
import '../questions_list.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});
  void _flavorsQuestionsDialog(BuildContext context, CartItem cartItem) {
    final MultiSelectController<Flavor> _flavorsController =
        MultiSelectController();
    final MultiSelectController<Question> _questionController =
        MultiSelectController();
    context.showCustomDialog(
      image: cartItem.product.icon,
      title: context.trValue(
          cartItem.product.proArName, cartItem.product.proEnName),
      onSubmit: () {
        List<Flavor> flavors = [];
        List<Question> questions = [];
        try {
          flavors = _flavorsController.getSelectedItems();
          questions = _questionController.getSelectedItems();
        } catch (e) {
          debugPrint(e.toString());
        }
        context.read<CartBloc>().add(UpdateCartEvent(
                cartItem: CartItem(
              product: cartItem.product,
              quantity: cartItem.quantity,
              flavors: flavors,
              questions: questions,
            )));
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
                catId: cartItem.product.catId,
                controller: _flavorsController,
                selectedFlavors: cartItem.flavors,
              )),
              const VerticalDivider(),
              Flexible(
                  child: QuestionsList(
                productId: cartItem.product.proId,
                controller: _questionController,
                selectedQuestions: cartItem.questions,
              )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize:
            context.ResponsiveValu(12, mobile: 10, tablet: 16, desktop: 25));
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
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    leading: state.cart[index].product.icon != null
                        ? Image.network(state.cart[index].product.icon!)
                        : null,
                    title: Text(
                      state.cart[index].product.proEnName,
                      style: style,
                    ),
                    subtitle: Text(state.cart[index].product.price.toString(),
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
                  onPressed: () =>
                      _flavorsQuestionsDialog(context, state.cart[index]),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}