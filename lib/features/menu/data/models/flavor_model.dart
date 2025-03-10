import 'dart:convert';
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
        price: double.parse(json[ApiKeys.price].toString()),
        warehouse: json[ApiKeys.warehouse],
        category: json[ApiKeys.category] is String
            ? List<String>.from(
                jsonDecode(json[ApiKeys.category]).map((x) => x))
            : List<String>.from(json[ApiKeys.category]),
        isActive: bool.tryParse(json[ApiKeys.isActive].toString()) ?? false,
      );

  @override
  Map<String, dynamic> toJson() => {
        ApiKeys.flavorNo: flavorNo,
        ApiKeys.flavorAr: flavorAr,
        ApiKeys.flavorEn: flavorEn,
        ApiKeys.price: price,
        ApiKeys.warehouse: warehouse,
        ApiKeys.category: jsonEncode(category),
        ApiKeys.isActive: isActive.toString(),
      };
}
