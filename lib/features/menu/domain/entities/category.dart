import 'package:equatable/equatable.dart';

abstract class Category extends Equatable {
  final String catId;
  final String catArName;
  final String catEnName;
  final String taxPercentage;
  final String? icon;
  final String? backColor;
  final String? foreColor;
  final String? price;
  final String? printer;
  final String? printer2;
  final String tag;
  final String? question1;
  final String? question2;
  final String? question3;
  final String? question4;
  final String? question5;
  final bool saleable;
  final bool standardItem;
  final bool? discountable;

  Category({
    required this.catId,
    required this.catArName,
    required this.catEnName,
    required this.taxPercentage,
    required this.icon,
    required this.backColor,
    required this.foreColor,
    required this.price,
    required this.printer,
    required this.printer2,
    required this.tag,
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.saleable,
    required this.standardItem,
    required this.discountable,
  });

  @override
  List<Object?> get props => [
        catId,
        catArName,
        catEnName,
        taxPercentage,
        icon,
        backColor,
        foreColor,
        price,
        printer,
        printer2,
        tag,
        question1,
        question2,
        question3,
        question4,
        question5,
        saleable,
        standardItem,
        discountable
      ];
}
