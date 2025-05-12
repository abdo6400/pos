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
  final int unitId;
  final double factor;
  final bool isSmall;
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
  final String tag;
  final bool standardItem;
  final bool isActive;
  final bool hotGroup;
  final bool isService;

  Product({
    required this.proId,
    required this.barcode,
    required this.proArName,
    required this.proEnName,
    required this.catId,
    required this.categoryAr,
    required this.categoryEn,
    required this.father,
    required this.unitId,
    required this.factor,
    required this.isSmall,
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
    required this.tag,
    required this.standardItem,
    required this.isActive,
    required this.hotGroup,
    required this.isService,
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
    int ?unitId,
    double? factor,
    bool? isSmall,
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
    String? tag,
    bool? standardItem,
    bool? isActive,
    bool? hotGroup,
    bool? isService,
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
    unitId,
    factor,
    isSmall,
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
    tag,
    standardItem,
    isActive,
    isService,
    hotGroup
      ];
}
