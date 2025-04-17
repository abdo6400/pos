import 'package:bloc/bloc.dart';

import '../../entities/auth_tokens.dart';
import '../../utils/constants.dart';

class UserCubit extends Cubit<AuthTokens?> {
  UserCubit() : super(null);

  void setUser() async {
    final userData = await storage.getUser();
    emit(userData);
  }

  void clearUser() async {
    await storage.clearUser();
    emit(null);
  }
}
