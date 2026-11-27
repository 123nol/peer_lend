import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peer_lend/features/auth/presentation/auth_controller.dart';
import 'package:peer_lend/features/loans/presentation/loan_controller.dart';
import 'package:peer_lend/features/offers/domain/offer.dart';
import 'package:peer_lend/features/offers/presentation/offer_controller.dart';
import 'package:peer_lend/features/requests/domain/loan_request.dart';
import 'package:peer_lend/features/requests/presentation/request_controller.dart';

void main() {
  test('lender approval and borrower confirmation create exactly one loan', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final auth = container.read(authProvider.notifier);
    final offers = container.read(offersProvider.notifier);
    final requests = container.read(requestsProvider.notifier);
    final offer = offers.find('offer-1')!;
    final initialLoanCount = container.read(loansProvider).length;

    auth.signIn('abel@demo.test', 'demo1234');
    requests.send(offer.id);
    final request = container.read(myRequestsProvider).single;
    expect(request.status, RequestStatus.pending);
    expect(request.termsSnapshot, offer.terms);

    auth.signIn('sara@demo.test', 'demo1234');
    requests.decide(request.id, approve: true);
    expect(
      container.read(myRequestsProvider).single.status,
      RequestStatus.approved,
    );
    expect(offers.find(offer.id)!.status, OfferStatus.reserved);
    expect(container.read(loansProvider), hasLength(initialLoanCount));

    auth.signIn('abel@demo.test', 'demo1234');
    final loanId = requests.confirm(request.id);
    final loan = container
        .read(myLoansProvider)
        .singleWhere((loan) => loan.requestId == request.id);
    expect(loan.id, loanId);
    expect(loan.termsSnapshot, request.termsSnapshot);
    expect(loan.instalments.map((item) => item.amountMinor), [
      34333,
      34333,
      34334,
    ]);
    expect(
      container.read(myRequestsProvider).single.status,
      RequestStatus.confirmed,
    );
    expect(offers.find(offer.id)!.status, OfferStatus.funded);

    expect(() => requests.confirm(request.id), throwsStateError);
    expect(container.read(loansProvider), hasLength(initialLoanCount + 1));
  });
}
