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
        saleable: bool.tryParse(json[ApiKeys.saleable].toString()) ?? false,
        standardItem:
            bool.tryParse(json[ApiKeys.standardItem].toString()) ?? false,
        discountable:
            bool.tryParse(json[ApiKeys.discountable].toString()) ?? false,
      );

  Map<String, dynamic> toJson() => {
        ApiKeys.catId: catId,
        ApiKeys.catArName: catArName,
        ApiKeys.catEnName: catEnName,
        ApiKeys.taxPercentage: taxPercentage,
        ApiKeys.icon: icon,
        ApiKeys.backColor: backColor,
        ApiKeys.foreColor: foreColor,
        ApiKeys.price: price,
        ApiKeys.printer: printer,
        ApiKeys.printer2: printer2,
        ApiKeys.tag: tag,
        ApiKeys.question1: question1,
        ApiKeys.question2: question2,
        ApiKeys.question3: question3,
        ApiKeys.question4: question4,
        ApiKeys.question5: question5,
        ApiKeys.saleable: saleable.toString(),
        ApiKeys.standardItem: standardItem.toString(),
        ApiKeys.discountable: discountable.toString(),
      };
}
