part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> cart;

  const CartState({required this.cart});

  CartState copyWith({List<CartItem>? cart}) {
    return CartState(
      cart: cart ?? this.cart,
    );
  }

  String GeneratQr(
      {required String seller,
      required String tax,
      required String amount,
      required String trn}) {
    String date = DateTime.now().toString();
    BytesBuilder bytesBuilder = BytesBuilder();
    // Seller Name
    bytesBuilder.addByte(1);
    List<int> sellerBytes = utf8.encode(seller);
    bytesBuilder.addByte(sellerBytes.length);
    bytesBuilder.add(sellerBytes);
    // TRN
    bytesBuilder.addByte(2);
    List<int> trnBytes = utf8.encode(trn);
    bytesBuilder.addByte(trnBytes.length);
    bytesBuilder.add(trnBytes);
    // Date
    bytesBuilder.addByte(3);
    List<int> dateBytes = utf8.encode(date);
    bytesBuilder.addByte(dateBytes.length);
    bytesBuilder.add(dateBytes);
    // Total Amount
    bytesBuilder.addByte(4);
    List<int> totalBytes = utf8.encode(tax);
    bytesBuilder.addByte(totalBytes.length);
    bytesBuilder.add(totalBytes);
    // Net Amount
    bytesBuilder.addByte(5);
    List<int> netBytes = utf8.encode(amount);
    bytesBuilder.addByte(netBytes.length);
    bytesBuilder.add(netBytes);
    Uint8List qrBytesGenerator = bytesBuilder.toBytes();
    Base64Encoder encoder = Base64Encoder();
    String result = encoder.convert(qrBytesGenerator);

    return result;
  }

  InvoiceParams createInvoice({
    double taxPercentage = 16.0,
    bool priceIncludesTax = true,
    double discount = 0.0,
    bool taxIncludesDiscount = true,
    int deliveryCategory = 1,
    double deliveryDiscount = 0.0,
    int branchId = 1,
    required String trn,
    required remind,
    int userNo = 1,
    bool isPrinted = false,
    bool addQrCode = false,
    required Map<int, double> payments,
  }) {
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
            invoiceSubTotal: double.parse(total.price.toStringAsFixed(5)),
            invoiceDiscountTotal:
                double.parse(total.discount.toStringAsFixed(5)),
            invoiceTaxTotal: double.parse(total.tax.toStringAsFixed(5)),
            invoiceGrandTotal:
                double.parse(total.grandTotal.toStringAsFixed(5)),
            warehouse: branchId,
            isPrinted: isPrinted,
            realTime: DateTime.now(),
            deliveryCompany: deliveryCategory,
            invoiceServiceTotal: 0,
            cashPayment: double.parse(total.grandTotal.toStringAsFixed(5)),
            customer: -1,
            tableNo: -1,
            empTaker: userNo,
            takerName: "",
            qrcode: addQrCode
                ? GeneratQr(
                    seller: branchId.toString(),
                    tax: total.tax.toStringAsFixed(remind),
                    amount: total.grandTotal.toStringAsFixed(remind),
                    trn: trn)
                : "",
            stationId: ""),
        invoicePayment: payments.entries.map((entry) {
          final int payType = entry.key;
          final double amount = entry.value;
          return InvoicePayment(
            payType: payType,
            payment: amount,
            warehouse: branchId,
          );
        }).toList(),
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
              subtotal: double.parse(details.price.toStringAsFixed(5)),
              discountV: double.parse(details.discount.toStringAsFixed(5)),
              discountP: discount,
              taxP: taxPercentage / 100,
              taxV: double.parse(details.tax.toStringAsFixed(5)),
              grandTotal: double.parse(details.grandTotal.toStringAsFixed(5)),
              taker: userNo,
              flavors:
                  cartItem.flavors.map((f) => f.flavorEn).toList().join(","),
              warehouse: branchId,
              offerNo: 0,
              lineId: cart.indexOf(cartItem));
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
