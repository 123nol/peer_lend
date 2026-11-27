import '../../../core/widgets/ui.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../offers/presentation/offer_widgets.dart';
import '../../repayments/domain/repayment.dart';
import '../../repayments/presentation/repayment_controller.dart';
import 'loan_controller.dart';

class LoanDetailScreen extends ConsumerWidget {
  const LoanDetailScreen({super.key, required this.loanId});
  final String loanId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loan = ref
        .watch(myLoansProvider)
        .where((l) => l.id == loanId)
        .firstOrNull;
    if (loan == null) return const MissingRecord();
    final user = ref.watch(authProvider);
    final repayments = ref
        .watch(repaymentsProvider)
        .where((r) => r.loanId == loanId)
        .toList();
    final balance = loanBalance(loan, repayments);
    final today = DateTime.now();
    return PageBody(
      title: 'Every step, in view.',
      subtitle: 'Loan $loanId · ${balance == 0 ? 'Completed' : 'Active'}',
      back: '/home',
      children: [
        DataState(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Panel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'REMAINING BALANCE',
                      style: TextStyle(letterSpacing: 1.5, fontSize: 11),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      money(balance),
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Only confirmed repayments reduce this balance.',
                    ),
                    if (balance > 0) ...[
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () =>
                            context.push('/loans/$loanId/repayments/new'),
                        icon: const Icon(Icons.add),
                        label: const Text('Record repayment'),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const SectionTitle('Repayment schedule'),
              for (var index = 0; index < loan.instalments.length; index++)
                Builder(
                  builder: (context) {
                    final item = loan.instalments[index];
                    final paid = confirmedFor(repayments, item.id);
                    final pending = repayments.any(
                      (r) =>
                          r.instalmentId == item.id &&
                          r.status == ConfirmationStatus.pending,
                    );
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Panel(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 12,
                              runSpacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  'Instalment ${index + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                StatusPill(
                                  paid == item.amountMinor
                                      ? 'Paid'
                                      : pending
                                      ? 'Awaiting confirmation'
                                      : item.isOverdueOn(today)
                                      ? 'Overdue'
                                      : 'Upcoming',
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${shortDate(item.dueDate)} · ${money(item.amountMinor)}',
                            ),
                            const SizedBox(height: 4),
                            Text('${money(paid)} confirmed'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 24),
              const SectionTitle('Repayment activity'),
              if (repayments.isEmpty)
                const Panel(child: Text('No repayments recorded yet.')),
              for (final repayment in repayments.reversed)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Panel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            Text(
                              money(repayment.amountMinor),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            StatusPill(repayment.status.name),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('Recorded ${shortDate(repayment.recordedAt)}'),
                        if (repayment.note.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(repayment.note),
                          ),
                        if (repayment.hasDemoReceipt)
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              'Sample receipt attached · simulated image',
                            ),
                          ),
                        if (repayment.status == ConfirmationStatus.pending) ...[
                          const SizedBox(height: 12),
                          if (repayment.recordedBy != user?.id)
                            FilledButton(
                              onPressed: () => perform(
                                context,
                                () => ref
                                    .read(repaymentsProvider.notifier)
                                    .confirm(repayment.id),
                                success: 'Repayment confirmed.',
                              ),
                              child: const Text('Confirm repayment'),
                            )
                          else
                            const Text(
                              'Waiting for the other participant to confirm.',
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              const SectionTitle('Confirmed terms'),
              TermsPanel(terms: loan.termsSnapshot),
            ],
          ),
        ),
      ],
    );
  }
}
