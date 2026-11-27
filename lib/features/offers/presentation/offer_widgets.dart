import '../../../core/widgets/ui.dart';
import '../domain/offer.dart';
import '../domain/repayment_calculator.dart';

class TermsPanel extends StatelessWidget {
  const TermsPanel({super.key, required this.terms});
  final LoanTerms terms;
  @override
  Widget build(BuildContext context) => Panel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PRINCIPAL',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          money(terms.principalMinor),
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            StatusPill(
              '${(terms.annualRateBps / 100).toStringAsFixed(2)}% annual interest',
            ),
            StatusPill('${terms.termMonths} months'),
          ],
        ),
        const Divider(),
        Text('Simple interest: ${money(RepaymentCalculator.interest(terms))}'),
        const SizedBox(height: 8),
        Text(
          'Total repayment: ${money(RepaymentCalculator.total(terms))}',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

class SchedulePreview extends StatelessWidget {
  const SchedulePreview({super.key, required this.terms});
  final LoanTerms terms;
  @override
  Widget build(BuildContext context) {
    final amounts = RepaymentCalculator.schedule(terms);
    return Panel(
      child: Column(
        children: [
          for (var i = 0; i < amounts.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(child: Text('Month ${i + 1}')),
                  Text(
                    money(amounts[i]),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
