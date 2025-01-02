import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/question.dart';
import '../repositories/menu_repository.dart';

class GetQuestionsUsecase
    extends UseCase<Either<Failure, List<Question>>, NoParams> {
  final MenuRepository _repository;

  GetQuestionsUsecase(this._repository);
  @override
  Future<Either<Failure, List<Question>>> call(NoParams params) {
    return _repository.getQuestions();
  }
}
