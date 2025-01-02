abstract class Question {
  final String productId;
  final String questionElements1;
  final int productQuestionId;
  final double productPrice;
  final bool isRequired;
  final String questionAr;

  Question({
    required this.productId,
    required this.questionElements1,
    required this.productQuestionId,
    required this.productPrice,
    required this.isRequired,
    required this.questionAr,
  });
}
