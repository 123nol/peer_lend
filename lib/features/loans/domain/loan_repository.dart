import 'loan.dart';

abstract interface class LoanRepository {
  List<Loan> getAll();
  void save(Loan loan);
}
