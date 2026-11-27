import 'repayment.dart';

abstract interface class RepaymentRepository {
  List<Repayment> getAll();
  void save(Repayment repayment);
}
