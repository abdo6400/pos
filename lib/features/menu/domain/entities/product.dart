import 'package:equatable/equatable.dart';

abstract class Product extends Equatable {
  final String proId;
  final String barcode;
  final String proArName;
  final String proEnName;
  final String catId;
  final String categoryAr;
  final String categoryEn;
  final String father;
  final double price;
  final double price2;
  final double price3;
  final double price4;
  final bool taxable;
  final double taxPercentage;
  final bool discountable;
  final String? icon;
  final String? backColor;
  final String? foreColor;
  final String? printer;
  final String? printer2;
  final String tag;
  final String? question1;
  final String? question2;
  final String? question3;
  final String? question4;
  final String? question5;
  final bool standardItem;
  final bool isActive;
  final bool rawMaterial;
  final bool compositeMaterial;
  final bool compo;
  final bool isMaximumQty;
  final String? question1Qty;
  final String? question2Qty;
  final String? question3Qty;
  final String? question4Qty;
  final String? question5Qty;

  Product({
    required this.proId,
    required this.barcode,
    required this.proArName,
    required this.proEnName,
    required this.catId,
    required this.categoryAr,
    required this.categoryEn,
    required this.father,
    required this.price,
    required this.price2,
    required this.price3,
    required this.price4,
    required this.taxable,
    required this.taxPercentage,
    required this.discountable,
    required this.icon,
    required this.backColor,
    required this.foreColor,
    required this.printer,
    required this.printer2,
    required this.tag,
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.standardItem,
    required this.isActive,
    required this.rawMaterial,
    required this.compositeMaterial,
    required this.compo,
    required this.isMaximumQty,
    required this.question1Qty,
    required this.question2Qty,
    required this.question3Qty,
    required this.question4Qty,
    required this.question5Qty,
  });

  Product copyWith({
    String? proId,
    String? barcode,
    String? proArName,
    String? proEnName,
    String? catId,
    String? categoryAr,
    String? categoryEn,
    String? father,
    double? price,
    double? price2,
    double? price3,
    double? price4,
    bool? taxable,
    double? taxPercentage,
    bool? discountable,
    String? icon,
    String? backColor,
    String? foreColor,
    String? printer,
    String? printer2,
    String? tag,
    String? question1,
    String? question2,
    String? question3,
    String? question4,
    String? question5,
    bool? standardItem,
    bool? isActive,
    bool? rawMaterial,
    bool? compositeMaterial,
    bool? compo,
    bool? isMaximumQty,
    String? question1Qty,
    String? question2Qty,
    String? question3Qty,
    String? question4Qty,
    String? question5Qty,
  });
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [
        proId,
        barcode,
        proArName,
        proEnName,
        catId,
        categoryAr,
        categoryEn,
        father,
        price,
        price2,
        price3,
        price4,
        taxable,
        taxPercentage,
        discountable,
        icon,
        backColor,
        foreColor,
        printer,
        printer2,
        tag,
        question1,
        question2,
        question3,
        question4,
        question5,
        standardItem,
        isActive,
        rawMaterial,
        compositeMaterial,
        compo,
        isMaximumQty,
        question1Qty,
        question2Qty,
        question3Qty,
        question4Qty,
        question5Qty
      ];
}
