import 'flavor.dart';
import 'product.dart';
import 'question.dart';

class CartItem {
  final Product product;
  final List<Flavor> flavors;
  final List<Question> questions;
  final int quantity;
  final String note;

  const CartItem({
    required this.product,
    required this.quantity,
    required this.flavors,
    required this.questions,
    this.note = '',
  });
}
