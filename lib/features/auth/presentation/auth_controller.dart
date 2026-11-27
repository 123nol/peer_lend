import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/in_memory_auth_repository.dart';
import '../domain/app_user.dart';
import '../domain/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => InMemoryAuthRepository(),
);
final authProvider = NotifierProvider<AuthController, AppUser?>(
  AuthController.new,
);

class AuthController extends Notifier<AppUser?> {
  @override
  AppUser? build() => null;
  void signIn(String email, String password) {
    state = ref.read(authRepositoryProvider).signIn(email, password);
  }

  void register(String name, String email, String password) {
    state = ref.read(authRepositoryProvider).register(name, email, password);
  }

  void signOut() => state = null;
}
