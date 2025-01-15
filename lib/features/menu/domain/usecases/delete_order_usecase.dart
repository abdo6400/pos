import '../../../../core/usecases/use_case.dart';
import '../repositories/menu_repository.dart';

class DeleteOrderUseCase extends UseCase<void, String> {
  final MenuRepository menuRepository;

  DeleteOrderUseCase(this.menuRepository);
  @override
  Future<void> call(String params) {
    return menuRepository.deleteOrder(params);
  }
}
