import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel(
      {required super.catId,
      required super.catArName,
      required super.catEnName,
      required super.taxPercentage,
      required super.icon,
      required super.backColor,
      required super.foreColor,
      required super.price,
      required super.printer,
      required super.printer2,
      required super.tag,
      required super.question1,
      required super.question2,
      required super.question3,
      required super.question4,
      required super.question5,
      required super.saleable,
      required super.standardItem,
      required super.discountable});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        catId: json[ApiKeys.catId],
        catArName: json[ApiKeys.catArName],
        catEnName: json[ApiKeys.catEnName],
        taxPercentage: json[ApiKeys.taxPercentage].toString(),
        icon: json[ApiKeys.icon],
        backColor: json[ApiKeys.backColor],
        foreColor: json[ApiKeys.foreColor],
        price: json[ApiKeys.price].toString(),
        printer: json[ApiKeys.printer],
        printer2: json[ApiKeys.printer2],
        tag: json[ApiKeys.tag],
        question1: json[ApiKeys.question1].toString(),
        question2: json[ApiKeys.question2].toString(),
        question3: json[ApiKeys.question3].toString(),
        question4: json[ApiKeys.question4].toString(),
        question5: json[ApiKeys.question5].toString(),
        saleable: json[ApiKeys.saleable],
        standardItem: json[ApiKeys.standardItem],
        discountable: json[ApiKeys.discountable],
      );
}
