import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../entities/category.dart';
import '../entities/delivery.dart';
import '../entities/delivery_discount.dart';
import '../entities/discount.dart';
import '../entities/flavor.dart';
import '../entities/offer.dart';
import '../entities/product.dart';
import '../entities/question.dart';
import '../entities/order.dart' as order;

abstract class MenuRepository {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<Product>>> getProducts(String branchId);
  Future<Either<Failure, List<Flavor>>> getFlavors();
  Future<Either<Failure, List<Delivery>>> getDeliveries();
  Future<Either<Failure, List<DeliveryDiscount>>> getDeliveryDiscounts();
  Future<Either<Failure, List<Question>>> getQuestions();
  Future<Either<Failure, List<Discount>>> getDiscounts(String branchId);
  Future<Either<Failure, List<Offer>>> getOffers(String branchId);
  Future<Either<Failure, List<order.Order>>> getOrders();
  Future<Either<Failure, void>> deleteOrder(String orderId);
  Future<Either<Failure, void>> clearOrder();
  Future<Either<Failure, void>> addOrder(Map<String, dynamic> order);
}
