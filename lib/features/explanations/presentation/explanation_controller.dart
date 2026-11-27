import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../offers/presentation/offer_controller.dart';
import '../../settings/presentation/preferences_controller.dart';
import '../data/fake_explanation_service.dart';
import '../domain/explanation_service.dart';

final explanationServiceProvider = Provider<ExplanationService>(
  (ref) => FakeExplanationService(),
);
final explanationProvider = FutureProvider.autoDispose.family<String, String>((
  ref,
  offerId,
) {
  if (!ref.watch(preferencesProvider).aiConsent) {
    throw StateError('Consent is required.');
  }
  final offer = ref
      .watch(offersProvider)
      .where((o) => o.id == offerId)
      .firstOrNull;
  if (offer == null) throw StateError('Offer not found.');
  return ref.watch(explanationServiceProvider).explain(offer.terms);
});
