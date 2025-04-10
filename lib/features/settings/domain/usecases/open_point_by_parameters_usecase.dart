import 'package:dartz/dartz.dart';
import '../../../../config/database/api/api_keys.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/cash.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/settings_repository.dart';

class OpenPointByParametersUsecase
    extends UseCase<Either<Failure, void>, OpenPointParams> {
  final SettingsRepository repository;

  OpenPointByParametersUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(OpenPointParams data) async {
    Cash? cash =  (await repository.getSalesByUser(data.userNo))
        .fold((l) => null, (r) => r);
    if(cash ==null){
      repository.insertByParameters({
        ApiKeys.warehouse: data.branchId,
        ApiKeys.lineDate: DateTime.now().toString().substring(0, 10),
        ApiKeys.openTime:DateTime.now().toString(),
      });
    }

    return repository.openPointByParameters(data.toJson(
        cash));
  }
}

class OpenPointParams {
  final int userNo;
  final String branchId;
  final double cashCustody;

  OpenPointParams({required this.userNo, required this.branchId,required this.cashCustody});

  // what wrong with this?not use this // ok?yes
  toJson(Cash? cash) => {
        ApiKeys.cashUser:userNo,
        ApiKeys.warehouse: branchId,
        ApiKeys.cashStartDate: cash?.cashStartDate??DateTime.now().toString().substring(0, 10),
        ApiKeys.cashCustody:cashCustody.toString(),
        ApiKeys.cashRealTime: DateTime.now().toString(),
      };
}
