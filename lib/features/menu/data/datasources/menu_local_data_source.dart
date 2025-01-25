import 'dart:convert';

import '../../../../config/database/local/local_consumer.dart';
import '../../../../config/database/local/tables_keys.dart';
import '../models/cart_model.dart';
import '../models/category_model.dart';
import '../models/flavor_model.dart';
import '../models/offer_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/question_model.dart';

abstract class MenuLocalDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getProducts();
  Future<List<FlavorModel>> getFlavors();
  Future<List<QuestionModel>> getQuestions();
  Future<List<OfferModel>> getOffers();
  Future<List<OrderModel>> getOrders();
  Future<void> deleteOrder(String orderId);
  Future<void> clearOrder();
  Future<void> insertOrder(Map<String, dynamic> order);
  Future<void> insertOffers(List<Map<String, dynamic>> dataList);
  Future<void> insertCategories(List<Map<String, dynamic>> dataList);
  Future<void> insertProducts(List<Map<String, dynamic>> dataList);
  Future<void> insertFlavors(List<Map<String, dynamic>> dataList);
  Future<void> insertQuestions(List<Map<String, dynamic>> dataList);
}

class MenuLocalDataSourceImpl extends MenuLocalDataSource {
  final LocalConsumer _localConsumer;

  MenuLocalDataSourceImpl({required LocalConsumer localConsumer})
      : _localConsumer = localConsumer;

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _localConsumer.queryAll(TablesKeys.categoryTable);
    return List<CategoryModel>.from(
        response.map((x) => CategoryModel.fromJson(x)));
  }

  @override
  Future<List<FlavorModel>> getFlavors() async {
    final response = await _localConsumer.queryAll(TablesKeys.flavorTable);
    return List<FlavorModel>.from(response.map((x) => FlavorModel.fromJson(x)));
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _localConsumer.queryAll(TablesKeys.productsTable);
    return List<ProductModel>.from(
        response.map((x) => ProductModel.fromJson(x)));
  }

  @override
  Future<List<QuestionModel>> getQuestions() async {
    final response =
        await _localConsumer.queryAll(TablesKeys.productQuestionsTable);
    return List<QuestionModel>.from(
        response.map((x) => QuestionModel.fromJson(x)));
  }

  @override
  Future<List<OfferModel>> getOffers() async {
    final response = await _localConsumer.queryAll(TablesKeys.offersTable);
    return List<OfferModel>.from(response.map((x) => OfferModel.fromJson(x)));
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final ordersResponse =
        await _localConsumer.queryAll(TablesKeys.ordersTable);
    final List<OrderModel> orders = [];

    for (var order in ordersResponse) {
      final orderId = order[TablesKeys.orderId];
      final cartItemsResponse = await _localConsumer.query(
        TablesKeys.cartItemTable,
        where: '${TablesKeys.orderId} = ?',
        whereArgs: [orderId],
      );
      final List<CartModel> cartItems = [];
      for (var cartItem in cartItemsResponse) {
        final cartItemId = cartItem[TablesKeys.cartItemId];
        final productId = cartItem[TablesKeys.cartItemProductId];

        // Fetch the product details from the products table
        final productResponse = await _localConsumer.query(
          TablesKeys.productsTable,
          where: '${TablesKeys.proId} = ?',
          whereArgs: [productId],
        );

        if (productResponse.isEmpty) {
          continue;
        }

        final product = ProductModel.fromJson(productResponse.first);

        final flavorsResponse = await _localConsumer.query(
          TablesKeys.cartItemFlavorTable,
          where: '${TablesKeys.cartItemId} = ?',
          whereArgs: [cartItemId],
        );

        final List<FlavorModel> flavors = [];
        for (var flavorNo in flavorsResponse) {
          final flavorDetailsResponse = await _localConsumer.query(
            TablesKeys.flavorTable,
            where: '${TablesKeys.flavorNo} = ?',
            whereArgs: [flavorNo],
          );

          if (flavorDetailsResponse.isNotEmpty) {
            flavors.add(FlavorModel.fromJson(flavorDetailsResponse.first));
          }
        }
        final questionsResponse = await _localConsumer.query(
          TablesKeys.cartItemQuestionTable,
          where: '${TablesKeys.cartItemId} = ?',
          whereArgs: [cartItemId],
        );
        final List<ProductModel> questions = [];
        for (var questionId in questionsResponse) {
          final questionDetailsResponse = await _localConsumer.query(
            TablesKeys.productsTable,
            where: '${TablesKeys.productId} = ?',
            whereArgs: [questionId],
          );
          if (questionDetailsResponse.isNotEmpty) {
            questions.add(ProductModel.fromJson(questionDetailsResponse.first));
          }
        }

        final offersResponse = await _localConsumer.query(
          TablesKeys.cartItemOfferTable,
          where: '${TablesKeys.cartItemId} = ?',
          whereArgs: [cartItemId],
        );
        final List<OfferModel> offers = [];
        for (var offerId in offersResponse) {
          final offerDetailsResponse = await _localConsumer.query(
            TablesKeys.offersTable,
            where: '${TablesKeys.offerId} = ?',
            whereArgs: [offerId],
          );
          if (offerDetailsResponse.isNotEmpty) {
            offers.add(OfferModel.fromJson(offerDetailsResponse.first));
          }
        }
        final cartItemModel = CartModel(
          id: cartItem[TablesKeys.cartItemId],
          product: product,
          quantity: cartItem[TablesKeys.cartItemQuantity],
          flavors: flavors,
          questions: questions,
          note: cartItem[TablesKeys.cartItemNote],
          offers: offers,
          isOffer: jsonDecode(cartItem[TablesKeys.cartItemIsOffer]),
          extraItemId: cartItem[TablesKeys.cartItemExtraItemId],
          orignialPrice: cartItem[TablesKeys.cartItemOriginalPrice],
        );
        cartItems.add(cartItemModel);
      }
      final orderModel = OrderModel(
        orderId: order[TablesKeys.orderId],
        orderDate: order[TablesKeys.orderDate],
        orderStatus: order[TablesKeys.orderStatus],
        cartItems: cartItems,
      );
      orders.add(orderModel);
    }

    return orders;
  }

  @override
  Future<void> insertCategories(List<Map<String, dynamic>> dataList) async {
    await _localConsumer.refreshDataIfNeeded(
        TablesKeys.categoryTable, dataList);
  }

  @override
  Future<void> insertFlavors(List<Map<String, dynamic>> dataList) async {
    await _localConsumer.refreshDataIfNeeded(TablesKeys.flavorTable, dataList);
  }

  @override
  Future<void> insertProducts(List<Map<String, dynamic>> dataList) async {
    await _localConsumer.refreshDataIfNeeded(
        TablesKeys.productsTable, dataList);
  }

  @override
  Future<void> insertQuestions(List<Map<String, dynamic>> dataList) async {
    await _localConsumer.refreshDataIfNeeded(
        TablesKeys.productQuestionsTable, dataList);
  }

  @override
  Future<void> insertOffers(List<Map<String, dynamic>> dataList) async {
    await _localConsumer.refreshDataIfNeeded(TablesKeys.offersTable, dataList);
  }

  @override
  Future<void> insertOrder(Map<String, dynamic> order) async {
    // Insert the order into the orders table
    await _localConsumer.insert(
      TablesKeys.ordersTable,
      {
        TablesKeys.orderId: order[TablesKeys.orderId],
        TablesKeys.orderDate: order[TablesKeys.orderDate],
        TablesKeys.orderStatus: order[TablesKeys.orderStatus],
      },
    );

    // Insert cart items into the cartItemTable
    final List<Map<String, dynamic>> cartItems =
        order[TablesKeys.cartItemTable];
    await _localConsumer.insertMultiple(
        TablesKeys.cartItemTable,
        cartItems
            .map(
              (cartItem) => {
                TablesKeys.cartItemId: cartItem[TablesKeys.cartItemId],
                TablesKeys.cartItemProductId:
                    cartItem[TablesKeys.cartItemProductId],
                TablesKeys.cartItemIsOffer:
                    cartItem[TablesKeys.cartItemIsOffer],
                TablesKeys.cartItemQuantity:
                    cartItem[TablesKeys.cartItemQuantity],
                TablesKeys.cartItemNote: cartItem[TablesKeys.cartItemNote],
                TablesKeys.cartItemExtraItemId:
                    cartItem[TablesKeys.cartItemExtraItemId],
                TablesKeys.cartItemOriginalPrice:
                    cartItem[TablesKeys.cartItemOriginalPrice],
                TablesKeys.orderId: order[TablesKeys.orderId],
              },
            )
            .toList());

    // Insert flavors, questions, and offers associated with each cart item
    for (var cartItem in cartItems) {
      final List<Map<String, dynamic>> flavors =
          cartItem[TablesKeys.cartItemFlavorTable];
      final List<Map<String, dynamic>> questions =
          cartItem[TablesKeys.cartItemQuestionTable];
      final List<Map<String, dynamic>> offers =
          cartItem[TablesKeys.cartItemOfferTable];

      if (flavors.isNotEmpty) {
        await _localConsumer.insertMultiple(
            TablesKeys.cartItemFlavorTable,
            flavors
                .map(
                  (flavor) => {
                    TablesKeys.cartItemId: cartItem[TablesKeys.cartItemId],
                    TablesKeys.flavorNo: flavor,
                  },
                )
                .toList());
      }

      if (questions.isNotEmpty) {
        await _localConsumer.insertMultiple(
            TablesKeys.cartItemQuestionTable,
            questions
                .map(
                  (question) => {
                    TablesKeys.cartItemId: cartItem[TablesKeys.cartItemId],
                    TablesKeys.productId: question,
                  },
                )
                .toList());
      }

      if (offers.isNotEmpty) {
        await _localConsumer.insertMultiple(
            TablesKeys.cartItemOfferTable,
            offers
                .map(
                  (offer) => {
                    TablesKeys.cartItemId: cartItem[TablesKeys.cartItemId],
                    TablesKeys.offerId: offer,
                  },
                )
                .toList());
      }
    }
  }

  @override
  Future<void> clearOrder() async {
    await _localConsumer.delete(TablesKeys.ordersTable);
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    await _localConsumer.delete(
      TablesKeys.ordersTable,
      where: '${TablesKeys.orderId} = ?',
      whereArgs: [orderId],
    );
  }
}
