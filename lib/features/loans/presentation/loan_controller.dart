import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/auth_controller.dart';
import '../../offers/domain/repayment_calculator.dart';
import '../../requests/domain/loan_request.dart';
import '../data/in_memory_loan_repository.dart';
import '../domain/loan.dart';
import '../domain/loan_repository.dart';

final loanRepositoryProvider = Provider<LoanRepository>(
  (ref) => InMemoryLoanRepository(),
);
final loansProvider = NotifierProvider<LoansController, List<Loan>>(
  LoansController.new,
);
final myLoansProvider = Provider<List<Loan>>((ref) {
  final user = ref.watch(authProvider);
  return ref
      .watch(loansProvider)
      .where((l) => l.borrowerId == user?.id || l.lenderId == user?.id)
      .toList();
});

class LoansController extends Notifier<List<Loan>> {
  @override
  List<Loan> build() => ref.read(loanRepositoryProvider).getAll();
  Loan? find(String id) => state.where((l) => l.id == id).firstOrNull;
  Loan createFromRequest(LoanRequest request) {
    if (request.status != RequestStatus.approved ||
        ref.read(authProvider)?.id != request.borrowerId) {
      throw StateError('Only the borrower can confirm approved terms.');
    }
    if (state.any((l) => l.requestId == request.id)) {
      throw StateError('This request already has a loan.');
    }
    final now = DateTime.now();
    final amounts = RepaymentCalculator.schedule(request.termsSnapshot);
    final id = 'loan-${request.id}';
    final loan = Loan(
      id: id,
      requestId: request.id,
      lenderId: request.lenderId,
      borrowerId: request.borrowerId,
      termsSnapshot: request.termsSnapshot,
      startDate: now,
      instalments: List.generate(amounts.length, (i) {
        final lastDay = DateTime(now.year, now.month + i + 2, 0).day;
        final day = now.day > lastDay ? lastDay : now.day;
        return Instalment(
          id: '$id-$i',
          dueDate: DateTime(now.year, now.month + i + 1, day),
          amountMinor: amounts[i],
        );
      }),
    );
    final repository = ref.read(loanRepositoryProvider);
    repository.save(loan);
    state = repository.getAll();
    return loan;
  }
}
