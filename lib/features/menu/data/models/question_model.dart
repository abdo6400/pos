import '../../../../config/database/api/api_keys.dart';
import '../../domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel(
      {required super.productId,
      required super.questionElements1,
      required super.productQuestionId,
      required super.productPrice,
      required super.isRequired,
      required super.questionAr});

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        productId: json[ApiKeys.productId],
        questionElements1: json[ApiKeys.questionElements1],
        productQuestionId: json[ApiKeys.productQuestionId],
        productPrice: json[ApiKeys.productPrice]?.toDouble() ?? 0.0,
        isRequired: bool.tryParse(json[ApiKeys.isRequired].toString()) ?? false,
        questionAr: json[ApiKeys.questionAr],
      );

  Map<String, dynamic> toJson() => {
        ApiKeys.productId: productId,
        ApiKeys.questionElements1: questionElements1,
        ApiKeys.productQuestionId: productQuestionId,
        ApiKeys.productPrice: productPrice,
        ApiKeys.isRequired: isRequired.toString(),
        ApiKeys.questionAr: questionAr,
      };
}
