import '../domain/app_user.dart';
import '../domain/auth_repository.dart';

/// Fictional demo credentials only; this is not production authentication.
class InMemoryAuthRepository implements AuthRepository {
  final _accounts = <String, (AppUser, String)>{
    'abel@demo.test': (
      const AppUser(
        id: 'borrower',
        displayName: 'Abel',
        email: 'abel@demo.test',
      ),
      'demo1234',
    ),
    'sara@demo.test': (
      const AppUser(id: 'lender', displayName: 'Sara', email: 'sara@demo.test'),
      'demo1234',
    ),
  };
  int _nextId = 1;
  @override
  AppUser signIn(String email, String password) {
    final account = _accounts[email.trim().toLowerCase()];
    if (account == null || account.$2 != password) {
      throw StateError('Email or password is incorrect.');
    }
    return account.$1;
  }

  @override
  AppUser register(String name, String email, String password) {
    final normalized = email.trim().toLowerCase();
    if (name.trim().isEmpty ||
        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(normalized)) {
      throw ArgumentError('Enter a name and a valid email address.');
    }
    if (password.length < 8) {
      throw ArgumentError('Use at least 8 password characters.');
    }
    if (_accounts.containsKey(normalized)) {
      throw StateError('That email is already registered.');
    }
    final user = AppUser(
      id: 'user-${_nextId++}',
      displayName: name.trim(),
      email: normalized,
    );
    _accounts[normalized] = (user, password);
    return user;
  }
}
