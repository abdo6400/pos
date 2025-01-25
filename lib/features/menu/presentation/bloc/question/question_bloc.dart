import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/use_case.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/usecases/get_questions_usecase.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final GetQuestionsUsecase _getQuestionsUsecase;
  QuestionBloc(this._getQuestionsUsecase) : super(QuestionInitial()) {
    on<GetQuestionsEvent>((event, emit) async {
      emit(QuestionLoading());
      final result = await _getQuestionsUsecase(NoParams());

      result.fold((failure) => emit(QuestionError(failure.message)),
          (questions) => emit(QuestionSuccess(questions)));
    });
  }
}
