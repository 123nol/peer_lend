import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/demo_mode.dart';
import '../../auth/presentation/auth_controller.dart';
import '../data/in_memory_offer_repository.dart';
import '../domain/offer.dart';
import '../domain/offer_repository.dart';
import '../domain/repayment_calculator.dart';

final offerRepositoryProvider = Provider<OfferRepository>(
  (ref) => InMemoryOfferRepository(),
);
final offersProvider = NotifierProvider<OffersController, List<Offer>>(
  OffersController.new,
);

class OffersController extends Notifier<List<Offer>> {
  int _nextId = 1;
  @override
  List<Offer> build() => ref.read(offerRepositoryProvider).getAll();
  Offer? find(String id) => state.where((o) => o.id == id).firstOrNull;
  String publish(LoanTerms terms, {String? id}) {
    requireWritable(ref);
    final user = ref.read(authProvider);
    if (user == null) throw StateError('Sign in first.');
    RepaymentCalculator.validate(terms);
    final existing = id == null ? null : find(id);
    if (id != null && existing == null) throw StateError('Offer not found.');
    if (existing != null &&
        (existing.lenderId != user.id ||
            existing.status != OfferStatus.available)) {
      throw StateError('Only your available offers can be edited.');
    }
    final offer = Offer(
      id: id ?? 'created-offer-${_nextId++}',
      lenderId: user.id,
      lenderName: user.displayName,
      terms: terms,
      version: (existing?.version ?? 0) + 1,
    );
    _save(offer);
    return offer.id;
  }

  /// Used by the request workflow after checking participant and status rules.
  void transition(String id, OfferStatus expected, OfferStatus next) {
    final offer = find(id);
    if (offer == null || offer.status != expected) {
      throw StateError('Offer is no longer available for this action.');
    }
    _save(offer.copyWith(status: next));
  }

  void _save(Offer offer) {
    final repository = ref.read(offerRepositoryProvider);
    repository.save(offer);
    state = repository.getAll();
  }
}

final offerFilterProvider = NotifierProvider<OfferFilterController, bool>(
  OfferFilterController.new,
);

class OfferFilterController extends Notifier<bool> {
  @override
  bool build() => false;
  void setInterestFree(bool value) => state = value;
}
