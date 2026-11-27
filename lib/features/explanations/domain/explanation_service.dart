import '../../offers/domain/offer.dart';

abstract interface class ExplanationService {
  Future<String> explain(LoanTerms terms);
}
