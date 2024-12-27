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
        catId: json["CatID"],
        catArName: json["Cat_AR_Name"],
        catEnName: json["Cat_EN_Name"],
        taxPercentage: json["TaxPercentage"].toString(),
        icon: json["Icon"],
        backColor: json["BackColor"],
        foreColor: json["ForeColor"],
        price: json["Price"].toString(),
        printer: json["Printer"],
        printer2: json["Printer2"],
        tag: json["Tag"],
        question1: json["Question1"].toString(),
        question2: json["Question2"].toString(),
        question3: json["Question3"].toString(),
        question4: json["Question4"].toString(),
        question5: json["Question5"].toString(),
        saleable: json["Saleable"],
        standardItem: json["StandardItem"],
        discountable: json["Discountable"],
      );
}
