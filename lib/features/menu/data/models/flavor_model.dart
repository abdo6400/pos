import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/flavor.dart';

class FlavorModel extends Flavor {
  FlavorModel(
      {required super.flavorNo,
      required super.flavorAr,
      required super.flavorEn,
      required super.price,
      required super.warehouse,
      required super.category,
      required super.isActive});

  factory FlavorModel.fromJson(Map<String, dynamic> json) => FlavorModel(
        flavorNo: json[ApiKeys.flavorNo],
        flavorAr: json[ApiKeys.flavorAr],
        flavorEn: json[ApiKeys.flavorEn],
        price: json[ApiKeys.price],
        warehouse: json[ApiKeys.warehouse],
        category: List<String>.from(json[ApiKeys.category].map((x) => x)),
        isActive: json[ApiKeys.isActive],
      );

  Map<String, dynamic> toJson() => {
        ApiKeys.flavorNo: flavorNo,
        ApiKeys.flavorAr: flavorAr,
        ApiKeys.flavorEn: flavorEn,
        ApiKeys.price: price,
        ApiKeys.warehouse: warehouse,
        ApiKeys.category: List<dynamic>.from(category.map((x) => x)),
        ApiKeys.isActive: isActive,
      };
}
