import '../domain/repayment.dart';
import '../domain/repayment_repository.dart';

class InMemoryRepaymentRepository implements RepaymentRepository {
  final _repayments = <String, Repayment>{
    'repayment-demo': Repayment(
      id: 'repayment-demo',
      loanId: 'loan-demo',
      instalmentId: 'demo-0',
      amountMinor: 34333,
      recordedBy: 'borrower',
      recordedAt: DateTime.now(),
      status: ConfirmationStatus.confirmed,
      note: 'Fictional repayment for the classroom demonstration.',
    ),
  };
  @override
  List<Repayment> getAll() => List.unmodifiable(_repayments.values);
  @override
  void save(Repayment repayment) => _repayments[repayment.id] = repayment;
}
