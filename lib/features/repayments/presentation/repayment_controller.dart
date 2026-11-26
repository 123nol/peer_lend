import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/demo_mode.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../loans/domain/loan.dart';
import '../../loans/presentation/loan_controller.dart';
import '../data/in_memory_repayment_repository.dart';
import '../domain/repayment.dart';
import '../domain/repayment_repository.dart';

final repaymentRepositoryProvider = Provider<RepaymentRepository>(
  (ref) => InMemoryRepaymentRepository(),
);
final repaymentsProvider =
    NotifierProvider<RepaymentsController, List<Repayment>>(
      RepaymentsController.new,
    );
int confirmedFor(List<Repayment> items, String instalmentId) => items
    .where(
      (r) =>
          r.instalmentId == instalmentId &&
          r.status == ConfirmationStatus.confirmed,
    )
    .fold(0, (total, r) => total + r.amountMinor);
int loanBalance(Loan loan, List<Repayment> items) => loan.instalments.fold(
  0,
  (total, i) => total + i.amountMinor - confirmedFor(items, i.id),
);

class RepaymentsController extends Notifier<List<Repayment>> {
  int _nextId = 1;
  @override
  List<Repayment> build() => ref.read(repaymentRepositoryProvider).getAll();
  void record({
    required String loanId,
    required String instalmentId,
    required int amountMinor,
    required DateTime date,
    String note = '',
    bool hasDemoReceipt = false,
  }) {
    requireWritable(ref);
    final user = ref.read(authProvider);
    final loan = ref.read(loansProvider.notifier).find(loanId);
    if (user == null ||
        loan == null ||
        (user.id != loan.borrowerId && user.id != loan.lenderId)) {
      throw StateError('You cannot access this loan.');
    }
    final instalment = loan.instalments
        .where((i) => i.id == instalmentId)
        .firstOrNull;
    if (instalment == null) throw StateError('Instalment not found.');
    final allocated = state
        .where((r) => r.instalmentId == instalmentId)
        .fold(0, (sum, r) => sum + r.amountMinor);
    if (amountMinor <= 0 || amountMinor > instalment.amountMinor - allocated) {
      throw ArgumentError(
        'Amount exceeds the unrecorded balance or is not positive.',
      );
    }
    if (date.isBefore(DateTime(2000)) || date.isAfter(DateTime.now())) {
      throw ArgumentError('Use a date between 2000 and today.');
    }
    _save(
      Repayment(
        id: 'repayment-${_nextId++}',
        loanId: loanId,
        instalmentId: instalmentId,
        amountMinor: amountMinor,
        recordedBy: user.id,
        recordedAt: date,
        note: note.trim(),
        hasDemoReceipt: hasDemoReceipt,
      ),
    );
  }

  void confirm(String id) {
    requireWritable(ref);
    final item = state.where((r) => r.id == id).firstOrNull;
    if (item == null || item.status != ConfirmationStatus.pending) {
      throw StateError('Repayment is not pending.');
    }
    final loan = ref.read(loansProvider.notifier).find(item.loanId);
    final user = ref.read(authProvider);
    if (loan == null ||
        user == null ||
        user.id == item.recordedBy ||
        (user.id != loan.borrowerId && user.id != loan.lenderId)) {
      throw StateError(
        'The other loan participant must confirm this repayment.',
      );
    }
    _save(item.copyWith(status: ConfirmationStatus.confirmed));
  }

  void _save(Repayment repayment) {
    final repository = ref.read(repaymentRepositoryProvider);
    repository.save(repayment);
    state = repository.getAll();
  }
}
