import 'flavor.dart';
import 'offer.dart';
import 'product.dart';

class CartItem {
  final Product product;
  final List<Flavor> flavors;
  final List<Product> questions;
  final List<Offer> offers;
  final int quantity;
  final String note;

  const CartItem({
    required this.product,
    required this.quantity,
    required this.flavors,
    required this.questions,
    required this.offers,
    this.note = '',
  });
}
