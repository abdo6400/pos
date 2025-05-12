import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:retail/core/utils/extensions/extensions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/utils/enums/string_enums.dart';
import '../../bloc/cubit/category_selection_cubit.dart';
import '../../bloc/cubit/offer_selection_cubit.dart';
import '../../bloc/cubit/search_cubit.dart';
import '../../bloc/cubit/barcode_reader_cubit.dart';
import '../../bloc/product/product_bloc.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_item.dart';
import '../../bloc/offer/offer_bloc.dart';
import '../../../domain/entities/offer.dart';
import '../../../domain/entities/product.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});
  static final TextEditingController _controller = TextEditingController();
  static final Uuid _uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is ProductLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.AppResponsiveValue(5,
                    mobile: 5, tablet: 2, desktop: 2)),
            child: BlocListener<BarcodeReaderCubit, String?>(
              listener: (context, barcode) {
                if (barcode != null) {
                  _handleBarcodeScanned(context, barcode);
                }
              },
              child: SearchBar(
                controller: _controller,
                elevation: const WidgetStatePropertyAll(0.2),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                leading: _buildBarcodeReader(context),
                textStyle: WidgetStatePropertyAll(Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(
                    fontSize: context.AppResponsiveValue(12,
                        mobile: 10, tablet: 20, desktop: 25))),
                onChanged: (value) {
                  _handleSearchChange(context, value);
                },
                hintText: StringEnums.search_about_item.name.tr(),
                hintStyle: WidgetStatePropertyAll(Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(
                    color: Theme.of(context).hintColor,
                    fontSize: context.AppResponsiveValue(12,
                        mobile: 10, tablet: 20, desktop: 25))),
                trailing: [
                  context.watch<SearchCubit>().state != null
                      ? IconButton(
                      onPressed: () {
                        _clearSearch(context);
                      },
                      icon: const Icon(Icons.clear))
                      : const Icon(Icons.search)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBarcodeReader(BuildContext context) {
    return BlocBuilder<OfferBloc, OfferState>(
      builder: (context, offerState) {
        final List<Offer> offers = offerState is OfferSuccess ? offerState.offers : [];

        return BarcodeKeyboardListener(
          bufferDuration: const Duration(milliseconds: 200),
          onBarcodeScanned: (barcode) {
            context.read<BarcodeReaderCubit>().setVisibility(barcode);
          },
          child: Icon(
            Icons.barcode_reader,
            color: Theme.of(context).colorScheme.secondary,
          ),
        );
      },
    );
  }

  void _handleBarcodeScanned(BuildContext context, String barcode) {
    final productState = context.read<ProductBloc>().state;
    final offerState = context.read<OfferBloc>().state;

    if (productState is ProductSuccess) {
      final List<Product> products = productState.filteredProductsByName(barcode);

      if (products.isNotEmpty) {
        final product = products.first;
        // final List<Offer> offers = offerState is OfferSuccess
        //     ? offers.where((x) => x.productId == product.proId).toList()
        //     : [];

        _controller.text = barcode;
        context.read<SearchCubit>().changeSearch(barcode);

        context.read<CartBloc>().add(AddCartEvent(
          cartItem: CartItem(
            id: _uuid.v4(),
            product: product,
            quantity: 1,
            flavors: [],
            questions: [],
            offers: [],
            orignialPrice: product.price,
          ),
        ));
      }
    }
  }

  void _handleSearchChange(BuildContext context, String value) {
    if (value.isNotEmpty) {
      //context.read<OfferSelectionCubit>().showHideOffer(false);
      context.read<CategorySelectionCubit>().selectCategory(null);
      context.read<SearchCubit>().changeSearch(value);
    } else {
      _clearSearch(context);
    }
  }

  void _clearSearch(BuildContext context) {
    context.read<SearchCubit>().changeSearch(null);
    _controller.clear();
  }
}