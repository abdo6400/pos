part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> cart;

  const CartState({required this.cart});

  CartState copyWith({List<CartItem>? cart}) {
    return CartState(
      cart: cart ?? this.cart,
    );
  }

  InvoiceParams createInvoice(
      {double taxPercentage = 16.0,
      bool priceIncludesTax = true,
      double discount = 0.0,
      bool taxIncludesDiscount = true,
      int deliveryCategory = 1,
      double deliveryDiscount = 0.0,
      int branchId = 1,
      int userNo = 1,
      bool isPrinted = false}) {
    final total = calculateTotalPrice(
        deliveryCategory: deliveryCategory,
        deliveryDiscount: deliveryDiscount,
        taxPercentage: taxPercentage,
        priceIncludesTax: priceIncludesTax,
        taxIncludesDiscount: taxIncludesDiscount,
        discount: discount);

    return InvoiceParams(
        branchId: branchId,
        invoices: Invoices(
            invoiceSubTotal: total.price,
            invoiceDiscountTotal: total.discount,
            invoiceTaxTotal: total.tax,
            invoiceGrandTotal: total.grandTotal,
            warehouse: branchId,
            isPrinted: isPrinted,
            realTime: DateTime.now(),
            deliveryCompany: deliveryCategory,
            invoiceServiceTotal: 0,
            cashPayment: total.grandTotal,
            customer: -1,
            tableNo: -1,
            empTaker: userNo,
            takerName: "",
            qrcode: "",
            stationId: ""),
        invoicePayment: [
          InvoicePayment(
            payType: 0,
            payment: total.grandTotal,
            warehouse: branchId,
          )
        ],
        invoiceDtl: cart.map((cartItem) {
          final details = cartItem.calculateTotalPriceAndTax(
              taxPercentage: taxPercentage,
              priceIncludesTax: priceIncludesTax,
              deliveryCategory: deliveryCategory,
              deliveryDiscount: deliveryDiscount,
              discount: discount,
              taxIncludesDiscount: taxIncludesDiscount);
          return InvoiceDtl(
            item: cartItem.product.proId,
            qty: cartItem.quantity,
            price: cartItem.getPrice(
                cartItem.product.price,
                cartItem.product.price2,
                cartItem.product.price3,
                cartItem.product.price4,
                deliveryCategory,
                deliveryDiscount),
            subtotal: details.price,
            discountV: details.discount,
            discountP: discount,
            taxP: taxPercentage / 100,
            taxV: details.tax,
            grandTotal: details.grandTotal,
            taker: userNo,
            flavors: cartItem.flavors.map((f) => f.flavorEn).toList().join(","),
            warehouse: branchId,
            offerNo: 0,
          );
        }).toList());
  }

  PriceAndTax calculateTotalPrice(
      {double taxPercentage = 16.0,
      bool priceIncludesTax = true,
      double discount = 0.0,
      bool taxIncludesDiscount = true,
      int deliveryCategory = 1,
      double deliveryDiscount = 0.0}) {
    double finalTotalPrice = 0.0;
    double totalTax = 0.0;
    double totalDiscount = 0.0;
    double grandTotal = 0.0;

    for (final cartItem in cart) {
      final totalPriceAndTax = cartItem.calculateTotalPriceAndTax(
          taxPercentage: taxPercentage,
          priceIncludesTax: priceIncludesTax,
          deliveryCategory: deliveryCategory,
          deliveryDiscount: deliveryDiscount,
          discount: discount,
          taxIncludesDiscount: taxIncludesDiscount);
      finalTotalPrice += totalPriceAndTax.price;
      totalDiscount += totalPriceAndTax.discount;
      totalTax += totalPriceAndTax.tax;
      grandTotal += totalPriceAndTax.grandTotal;
    }
    return PriceAndTax(
        price: finalTotalPrice,
        tax: totalTax,
        discount: totalDiscount,
        grandTotal: grandTotal);
  }

  @override
  List<Object> get props => [cart];
}
