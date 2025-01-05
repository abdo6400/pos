part of 'question_bloc.dart';

sealed class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

final class QuestionInitial extends QuestionState {}

class QuestionLoading extends QuestionState {}

class QuestionSuccess extends QuestionState {
  final List<Question> questions;
  const QuestionSuccess(this.questions);

  List<Question> filterQuestionsByProduct(String productId) {
    try {
      return questions
          .where((x) => x.productId.toString() == productId)
          .toList();
    } catch (e) {
      return [];
    }
  }
}

class QuestionError extends QuestionState {
  final String message;
  const QuestionError(this.message);
}
