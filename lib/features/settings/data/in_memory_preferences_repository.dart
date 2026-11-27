import '../domain/preferences.dart';

class InMemoryPreferencesRepository implements PreferencesRepository {
  final _items = <String, Preferences>{};
  @override
  Preferences get(String userId) => _items[userId] ?? const Preferences();
  @override
  void save(String userId, Preferences preferences) =>
      _items[userId] = preferences;
}
