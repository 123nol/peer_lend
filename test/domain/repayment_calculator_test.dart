import 'package:flutter_test/flutter_test.dart';
import 'package:peer_lend/features/offers/domain/offer.dart';
import 'package:peer_lend/features/offers/domain/repayment_calculator.dart';
import 'package:peer_lend/features/loans/domain/loan.dart';
import 'package:peer_lend/features/offers/data/in_memory_offer_repository.dart';
import 'package:peer_lend/features/auth/data/in_memory_auth_repository.dart';

void main() {
  const terms = LoanTerms(
    principalMinor: 100000,
    annualRateBps: 1200,
    termMonths: 3,
  );
  test('proposal example produces 30 ETB interest and exact instalments', () {
    expect(RepaymentCalculator.interest(terms), 3000);
    expect(RepaymentCalculator.total(terms), 103000);
    expect(RepaymentCalculator.schedule(terms), [34333, 34333, 34334]);
  });
  test('interest-free loan preserves principal', () {
    final free = terms.copyWith(
      principalMinor: 50000,
      annualRateBps: 0,
      termMonths: 2,
    );
    expect(RepaymentCalculator.schedule(free), [25000, 25000]);
  });
  test('rounding is exact for boundary amounts and all allowed terms', () {
    for (final principal in [100, 101, 99999, 100000000]) {
      for (var months = 1; months <= 60; months++) {
        final example = terms.copyWith(
          principalMinor: principal,
          termMonths: months,
        );
        final schedule = RepaymentCalculator.schedule(example);
        expect(schedule.length, months);
        expect(
          schedule.fold(0, (a, b) => a + b),
          RepaymentCalculator.total(example),
        );
        expect(schedule.every((i) => i > 0), isTrue);
      }
    }
  });
  test('invalid amount, rate and term are rejected', () {
    for (final invalid in [
      terms.copyWith(principalMinor: 0),
      terms.copyWith(annualRateBps: -1),
      terms.copyWith(annualRateBps: 10001),
      terms.copyWith(termMonths: 0),
      terms.copyWith(termMonths: 61),
    ]) {
      expect(() => RepaymentCalculator.schedule(invalid), throwsArgumentError);
    }
  });
  test('terms are value objects and copyWith preserves original snapshot', () {
    expect(
      terms,
      const LoanTerms(
        principalMinor: 100000,
        annualRateBps: 1200,
        termMonths: 3,
      ),
    );
    expect(terms.copyWith(termMonths: 6), isNot(terms));
    expect(terms.termMonths, 3);
  });
  test('loan copies its schedule and exposes an immutable list', () {
    final schedule = [
      Instalment(id: 'one', dueDate: DateTime(2026), amountMinor: 100),
    ];
    final loan = Loan(
      id: 'test',
      requestId: 'request',
      lenderId: 'a',
      borrowerId: 'b',
      termsSnapshot: terms,
      startDate: DateTime(2026),
      instalments: schedule,
    );
    schedule.clear();
    expect(loan.instalments, hasLength(1));
    expect(() => loan.instalments.clear(), throwsUnsupportedError);
  });
  test('repositories expose immutable snapshots and independent instances', () {
    final first = InMemoryOfferRepository();
    final snapshot = first.getAll();
    expect(() => snapshot.clear(), throwsUnsupportedError);
    first.save(snapshot.first.copyWith(id: 'new'));
    expect(snapshot, hasLength(3));
    expect(first.getAll(), hasLength(4));
    expect(InMemoryOfferRepository().getAll(), hasLength(3));
  });
  test('demo auth validates credentials and duplicate registrations', () {
    final auth = InMemoryAuthRepository();
    expect(auth.signIn(' ABEL@DEMO.TEST ', 'demo1234').id, 'borrower');
    expect(() => auth.signIn('abel@demo.test', 'wrongpass'), throwsStateError);
    final user = auth.register('New User', 'new@demo.test', 'password123');
    expect(auth.signIn('new@demo.test', 'password123'), user);
    expect(
      () => auth.register('Other', 'NEW@demo.test', 'password123'),
      throwsStateError,
    );
    expect(() => auth.register('', 'bad', 'short'), throwsArgumentError);
  });
}
