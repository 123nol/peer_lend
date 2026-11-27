import 'app_user.dart';

abstract interface class AuthRepository {
  AppUser signIn(String email, String password);
  AppUser register(String name, String email, String password);
}
