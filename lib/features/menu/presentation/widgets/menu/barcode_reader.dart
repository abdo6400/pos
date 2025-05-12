import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/offer.dart';
import '../../../domain/entities/product.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_item.dart';
import '../../bloc/cubit/barcode_reader_cubit.dart';
import '../../bloc/cubit/search_cubit.dart';
import '../../bloc/offer/offer_bloc.dart';
import '../../bloc/product/product_bloc.dart';

class BarcodeReader extends StatelessWidget {
   final TextEditingController controller;
  const BarcodeReader(this.controller);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferBloc, OfferState>(
        builder: (context, offerState) {
          final List<Offer> offers =
          offerState is OfferSuccess ? offerState.offers : [];

          return BlocBuilder<ProductBloc, ProductState>(
              builder: (context, productsState) {

               return BlocConsumer<BarcodeReaderCubit, String?>(
              listener: (context, filter) {

                if(filter!=null){
                  List<Product> products = productsState is ProductSuccess
                      ? productsState.filteredProductsByName(
                      filter)
                      : [];
                  if(products.isNotEmpty){
                    final product = products.first;

                    final List<Offer> productOffers =  offers
                        .where(
                          (x) => x.productId == product.proId,
                    )
                        .toList()
                        ;
                    controller.setText(filter);
                    context.read<CartBloc>().add(AddCartEvent(
                        cartItem: CartItem(
                            id: Uuid().v4(),
                            product: product,
                            quantity: 1,
                            flavors: [],
                            questions: [],
                            offers: productOffers,
                            orignialPrice: product.price)));
                    context.read<SearchCubit>().changeSearch(filter);
                  }

                }
              },
              builder: (context, scan) {
                return  BarcodeKeyboardListener(
                      bufferDuration: Duration(milliseconds: 200),
                      onBarcodeScanned: (barcode) {
                        context.read<BarcodeReaderCubit>().setVisibility(barcode);
                      },
                      child: Icon(
                        Icons.barcode_reader,
                        color:  Theme.of(context).colorScheme.secondary,
                      )
                );
              },
            );
          }
        );
      }
    );
  }
}
