import 'loan_request.dart';

abstract interface class RequestRepository {
  List<LoanRequest> getAll();
  void save(LoanRequest request);
}
