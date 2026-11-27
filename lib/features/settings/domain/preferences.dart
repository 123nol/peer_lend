import 'package:freezed_annotation/freezed_annotation.dart';
part 'preferences.freezed.dart';

@freezed
abstract class Preferences with _$Preferences {
  const factory Preferences({
    @Default(false) bool reminders,
    @Default(false) bool aiConsent,
  }) = _Preferences;
}

abstract interface class PreferencesRepository {
  Preferences get(String userId);
  void save(String userId, Preferences preferences);
}
