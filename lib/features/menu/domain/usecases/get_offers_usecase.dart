import 'package:dartz/dartz.dart';

import '../../../../config/database/error/failures.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/offer.dart';
import '../repositories/menu_repository.dart';

class GetOffersUseCase extends UseCase<Either<Failure, List<Offer>>, String> {
  final MenuRepository repository;
  GetOffersUseCase(this.repository);
  @override
  Future<Either<Failure, List<Offer>>> call(String params) {
    return repository.getOffers(params);
  }
}
