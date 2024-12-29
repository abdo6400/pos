abstract class Product {
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
}
