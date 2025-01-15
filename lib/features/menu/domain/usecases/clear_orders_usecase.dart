import '../../../../core/usecases/use_case.dart';
import '../repositories/menu_repository.dart';

class ClearOrdersUseCase extends UseCase<void, NoParams> {
  final MenuRepository menuRepository;

  ClearOrdersUseCase(this.menuRepository);
  @override
  Future<void> call(NoParams params) {
    return menuRepository.clearOrder();
  }
}
