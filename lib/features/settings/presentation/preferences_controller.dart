import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/auth_controller.dart';
import '../data/in_memory_preferences_repository.dart';
import '../domain/preferences.dart';

final preferencesRepositoryProvider = Provider<PreferencesRepository>(
  (ref) => InMemoryPreferencesRepository(),
);
final preferencesProvider =
    NotifierProvider<PreferencesController, Preferences>(
      PreferencesController.new,
    );

class PreferencesController extends Notifier<Preferences> {
  @override
  Preferences build() {
    final user = ref.watch(authProvider);
    return user == null
        ? const Preferences()
        : ref.read(preferencesRepositoryProvider).get(user.id);
  }

  void update({bool? reminders, bool? aiConsent}) {
    final user = ref.read(authProvider);
    if (user == null) throw StateError('Sign in first.');
    state = state.copyWith(
      reminders: reminders ?? state.reminders,
      aiConsent: aiConsent ?? state.aiConsent,
    );
    ref.read(preferencesRepositoryProvider).save(user.id, state);
  }
}
