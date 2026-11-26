import '../domain/loan_request.dart';
import '../domain/request_repository.dart';

class InMemoryRequestRepository implements RequestRepository {
  final _requests = <String, LoanRequest>{};
  @override
  List<LoanRequest> getAll() => List.unmodifiable(_requests.values);
  @override
  void save(LoanRequest request) => _requests[request.id] = request;
}
