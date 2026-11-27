import '../../offers/domain/offer.dart';
import '../domain/loan.dart';
import '../domain/loan_repository.dart';

class InMemoryLoanRepository implements LoanRepository {
  InMemoryLoanRepository() {
    final now = DateTime.now();
    _loans['loan-demo'] = Loan(
      id: 'loan-demo',
      requestId: 'seed-request',
      lenderId: 'lender',
      borrowerId: 'borrower',
      termsSnapshot: const LoanTerms(
        principalMinor: 100000,
        annualRateBps: 1200,
        termMonths: 3,
      ),
      startDate: now,
      instalments: List.generate(
        3,
        (i) => Instalment(
          id: 'demo-$i',
          dueDate: DateTime(now.year, now.month + i + 1, 15),
          amountMinor: i == 2 ? 34334 : 34333,
        ),
      ),
    );
  }
  final _loans = <String, Loan>{};
  @override
  List<Loan> getAll() => List.unmodifiable(_loans.values);
  @override
  void save(Loan loan) => _loans[loan.id] = loan;
}
