import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peer_lend/core/providers/demo_mode.dart';
import 'package:peer_lend/features/auth/presentation/auth_controller.dart';
import 'package:peer_lend/features/loans/presentation/loan_controller.dart';
import 'package:peer_lend/features/offers/domain/offer.dart';
import 'package:peer_lend/features/offers/domain/offer_repository.dart';
import 'package:peer_lend/features/offers/presentation/offer_controller.dart';
import 'package:peer_lend/features/repayments/domain/repayment.dart';
import 'package:peer_lend/features/repayments/presentation/repayment_controller.dart';
import 'package:peer_lend/features/requests/domain/loan_request.dart';
import 'package:peer_lend/features/requests/presentation/request_controller.dart';
import 'package:peer_lend/features/settings/presentation/preferences_controller.dart';

class EmptyOfferRepository implements OfferRepository {
  @override
  List<Offer> getAll() => [];
  @override
  void save(Offer offer) {}
}

void main() {
  late ProviderContainer container;
  void signIn(String name) => container
      .read(authProvider.notifier)
      .signIn('$name@demo.test', 'demo1234');
  setUp(() {
    container = ProviderContainer();
  });
  tearDown(() {
    container.dispose();
  });

  test('repository interface can be overridden for tests', () {
    final isolated = ProviderContainer(
      overrides: [
        offerRepositoryProvider.overrideWithValue(EmptyOfferRepository()),
      ],
    );
    addTearDown(isolated.dispose);
    expect(isolated.read(offersProvider), isEmpty);
  });
  test('borrower request, lender approval and borrower confirmation create one loan', () {
    signIn('abel');
    final controller = container.read(requestsProvider.notifier);
    controller.send('offer-1');
    final request = container.read(requestsProvider).single;
    expect(request.status, RequestStatus.pending);
    expect(
      () => controller.decide(request.id, approve: true),
      throwsStateError,
    );
    signIn('sara');
    controller.decide(request.id, approve: true);
    expect(
      container.read(offersProvider.notifier).find('offer-1')!.status,
      OfferStatus.reserved,
    );
    expect(() => controller.confirm(request.id), throwsStateError);
    signIn('abel');
    final id = controller.confirm(request.id);
    final loan = container.read(loansProvider.notifier).find(id)!;
    expect(loan.termsSnapshot, request.termsSnapshot);
    expect(loan.instalments.map((i) => i.amountMinor), [34333, 34333, 34334]);
    expect(
      container.read(offersProvider.notifier).find('offer-1')!.status,
      OfferStatus.funded,
    );
    expect(() => controller.confirm(request.id), throwsStateError);
    expect(container.read(loansProvider), hasLength(2));
  });
  test('self requests and duplicate requests are rejected', () {
    signIn('sara');
    final controller = container.read(requestsProvider.notifier);
    expect(() => controller.send('offer-1'), throwsStateError);
    signIn('abel');
    controller.send('offer-1');
    expect(() => controller.send('offer-1'), throwsStateError);
    expect(() => controller.send('unknown'), throwsStateError);
  });
  test('approving an offer declines competing pending requests', () {
    signIn('abel');
    final controller = container.read(requestsProvider.notifier);
    controller.send('offer-1');
    final first = container.read(requestsProvider).single;
    container
        .read(authProvider.notifier)
        .register('New', 'new@demo.test', 'password123');
    controller.send('offer-1');
    final second = container.read(requestsProvider).last;
    signIn('sara');
    controller.decide(first.id, approve: true);
    expect(
      container.read(requestsProvider).last.status,
      RequestStatus.declined,
    );
    expect(() => controller.decide(second.id, approve: true), throwsStateError);
  });
  test('edited terms cannot silently replace a pending request snapshot', () {
    signIn('abel');
    container.read(requestsProvider.notifier).send('offer-1');
    final request = container.read(requestsProvider).single;
    signIn('sara');
    container
        .read(offersProvider.notifier)
        .publish(
          request.termsSnapshot.copyWith(annualRateBps: 1500),
          id: 'offer-1',
        );
    expect(request.termsSnapshot.annualRateBps, 1200);
    expect(
      () => container
          .read(requestsProvider.notifier)
          .decide(request.id, approve: true),
      throwsStateError,
    );
  });
  test('only owners can edit available offers', () {
    signIn('abel');
    final offers = container.read(offersProvider.notifier);
    final terms = offers.find('offer-1')!.terms;
    expect(() => offers.publish(terms, id: 'offer-1'), throwsStateError);
    final id = offers.publish(terms);
    expect(offers.find(id)!.lenderId, 'borrower');
    signIn('sara');
    offers.publish(terms.copyWith(termMonths: 4), id: 'offer-1');
    expect(offers.find('offer-1')!.version, 2);
  });
  test('pending repayments reserve amount but do not reduce balance', () {
    signIn('abel');
    final repayments = container.read(repaymentsProvider.notifier);
    final loan = container.read(loansProvider.notifier).find('loan-demo')!;
    final before = loanBalance(loan, container.read(repaymentsProvider));
    repayments.record(
      loanId: loan.id,
      instalmentId: 'demo-1',
      amountMinor: 34333,
      date: DateTime.now(),
    );
    final id = container.read(repaymentsProvider).last.id;
    expect(loanBalance(loan, container.read(repaymentsProvider)), before);
    expect(() => repayments.confirm(id), throwsStateError);
    expect(
      () => repayments.record(
        loanId: loan.id,
        instalmentId: 'demo-1',
        amountMinor: 1,
        date: DateTime.now(),
      ),
      throwsArgumentError,
    );
    signIn('sara');
    repayments.confirm(id);
    expect(
      loanBalance(loan, container.read(repaymentsProvider)),
      before - 34333,
    );
    expect(
      container.read(repaymentsProvider).last.status,
      ConfirmationStatus.confirmed,
    );
    expect(() => repayments.confirm(id), throwsStateError);
  });
  test('confirmed final repayments complete the loan', () {
    signIn('abel');
    final repayments = container.read(repaymentsProvider.notifier);
    for (final entry in [('demo-1', 34333), ('demo-2', 34334)]) {
      repayments.record(
        loanId: 'loan-demo',
        instalmentId: entry.$1,
        amountMinor: entry.$2,
        date: DateTime.now(),
      );
    }
    signIn('sara');
    for (final repayment
        in container
            .read(repaymentsProvider)
            .where((r) => r.status == ConfirmationStatus.pending)
            .toList()) {
      repayments.confirm(repayment.id);
    }
    expect(
      loanBalance(
        container.read(myLoansProvider).single,
        container.read(repaymentsProvider),
      ),
      0,
    );
  });
  test('unrelated accounts cannot read private lists or mutate repayments', () {
    container
        .read(authProvider.notifier)
        .register('New', 'new@demo.test', 'password123');
    expect(container.read(myLoansProvider), isEmpty);
    expect(container.read(myRequestsProvider), isEmpty);
    expect(
      () => container
          .read(repaymentsProvider.notifier)
          .record(
            loanId: 'loan-demo',
            instalmentId: 'demo-1',
            amountMinor: 100,
            date: DateTime.now(),
          ),
      throwsStateError,
    );
  });
  test('offline blocks financial mutations but preserves data', () {
    signIn('abel');
    container.read(demoModeProvider.notifier).setMode(DemoMode.offline);
    expect(container.read(myLoansProvider), hasLength(1));
    expect(
      () => container.read(requestsProvider.notifier).send('offer-1'),
      throwsStateError,
    );
    expect(
      () => container
          .read(offersProvider.notifier)
          .publish(
            const LoanTerms(
              principalMinor: 100,
              annualRateBps: 0,
              termMonths: 1,
            ),
          ),
      throwsStateError,
    );
  });
  test('preferences belong to the signed-in account', () {
    signIn('abel');
    container
        .read(preferencesProvider.notifier)
        .update(reminders: true, aiConsent: true);
    signIn('sara');
    expect(container.read(preferencesProvider).reminders, isFalse);
    expect(container.read(preferencesProvider).aiConsent, isFalse);
    signIn('abel');
    expect(container.read(preferencesProvider).reminders, isTrue);
    container.read(authProvider.notifier).signOut();
    expect(container.read(myLoansProvider), isEmpty);
    expect(container.read(preferencesProvider).aiConsent, isFalse);
  });
}
