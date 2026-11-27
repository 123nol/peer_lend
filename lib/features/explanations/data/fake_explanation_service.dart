import '../../offers/domain/offer.dart';
import '../../offers/domain/repayment_calculator.dart';
import '../domain/explanation_service.dart';

class FakeExplanationService implements ExplanationService {
  @override
  Future<String> explain(LoanTerms terms) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final interest = (RepaymentCalculator.interest(terms) / 100)
        .toStringAsFixed(2);
    final total = (RepaymentCalculator.total(terms) / 100).toStringAsFixed(2);
    return 'This example uses simple interest. The principal is multiplied by '
        'the annual rate and by ${terms.termMonths}/12 of a year. '
        'That adds $interest ETB in interest, for a total of $total ETB. '
        'The total is split into ${terms.termMonths} monthly instalments; '
        'any rounding remainder goes into the final instalment. '
        'Only repayments confirmed by the other participant reduce the balance.';
  }
}
