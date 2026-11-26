import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/demo_mode.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../loans/presentation/loan_controller.dart';
import '../../offers/domain/offer.dart';
import '../../offers/presentation/offer_controller.dart';
import '../data/in_memory_request_repository.dart';
import '../domain/loan_request.dart';
import '../domain/request_repository.dart';

final requestRepositoryProvider = Provider<RequestRepository>(
  (ref) => InMemoryRequestRepository(),
);
final requestsProvider =
    NotifierProvider<RequestsController, List<LoanRequest>>(
      RequestsController.new,
    );
final myRequestsProvider = Provider<List<LoanRequest>>((ref) {
  final user = ref.watch(authProvider);
  return ref
      .watch(requestsProvider)
      .where((r) => r.borrowerId == user?.id || r.lenderId == user?.id)
      .toList();
});

class RequestsController extends Notifier<List<LoanRequest>> {
  int _nextId = 1;
  @override
  List<LoanRequest> build() => ref.read(requestRepositoryProvider).getAll();
  void send(String offerId) {
    requireWritable(ref);
    final user = ref.read(authProvider);
    final offer = ref.read(offersProvider.notifier).find(offerId);
    if (user == null) throw StateError('Sign in first.');
    if (offer == null || offer.status != OfferStatus.available) {
      throw StateError('Offer is unavailable.');
    }
    if (offer.lenderId == user.id) {
      throw StateError('You cannot request your own offer.');
    }
    if (state.any(
      (r) =>
          r.offerId == offerId &&
          r.borrowerId == user.id &&
          r.status != RequestStatus.declined,
    )) {
      throw StateError('You already requested this offer.');
    }
    _save(
      LoanRequest(
        id: 'request-${_nextId++}',
        offerId: offerId,
        lenderId: offer.lenderId,
        borrowerId: user.id,
        borrowerName: user.displayName,
        termsSnapshot: offer.terms,
        createdAt: DateTime.now(),
      ),
    );
  }

  void decide(String id, {required bool approve}) {
    requireWritable(ref);
    final request = _find(id);
    if (request.lenderId != ref.read(authProvider)?.id ||
        request.status != RequestStatus.pending) {
      throw StateError('Only the lender can decide a pending request.');
    }
    if (approve) {
      final offers = ref.read(offersProvider.notifier);
      final offer = offers.find(request.offerId);
      if (offer?.terms != request.termsSnapshot) {
        throw StateError(
          'Terms changed. Decline this request and ask for a new one.',
        );
      }
      offers.transition(
        request.offerId,
        OfferStatus.available,
        OfferStatus.reserved,
      );
      // Synchronous in-memory operations form one uninterrupted transition.
      for (final other
          in state
              .where(
                (r) =>
                    r.offerId == request.offerId &&
                    r.id != id &&
                    r.status == RequestStatus.pending,
              )
              .toList()) {
        _save(other.copyWith(status: RequestStatus.declined));
      }
    }
    _save(
      request.copyWith(
        status: approve ? RequestStatus.approved : RequestStatus.declined,
      ),
    );
  }

  String confirm(String id) {
    requireWritable(ref);
    final request = _find(id);
    if (request.borrowerId != ref.read(authProvider)?.id ||
        request.status != RequestStatus.approved) {
      throw StateError('Only the borrower can confirm an approved request.');
    }
    final offers = ref.read(offersProvider.notifier);
    if (offers.find(request.offerId)?.status != OfferStatus.reserved) {
      throw StateError('This offer is not reserved.');
    }
    final loan = ref.read(loansProvider.notifier).createFromRequest(request);
    offers.transition(
      request.offerId,
      OfferStatus.reserved,
      OfferStatus.funded,
    );
    _save(request.copyWith(status: RequestStatus.confirmed));
    return loan.id;
  }

  LoanRequest _find(String id) =>
      state.where((r) => r.id == id).firstOrNull ??
      (throw StateError('Request not found.'));
  void _save(LoanRequest request) {
    final repository = ref.read(requestRepositoryProvider);
    repository.save(request);
    state = repository.getAll();
  }
}
