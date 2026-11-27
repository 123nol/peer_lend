import '../../../core/widgets/ui.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../repayments/presentation/repayment_controller.dart';
import '../../requests/domain/loan_request.dart';
import '../../requests/presentation/request_controller.dart';
import 'loan_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final loans = ref.watch(myLoansProvider);
    final repayments = ref.watch(repaymentsProvider);
    final active = loans.where((l) => loanBalance(l, repayments) > 0).toList();
    final completed = loans
        .where((l) => loanBalance(l, repayments) == 0)
        .toList();
    final balance = loans.fold(0, (sum, l) => sum + loanBalance(l, repayments));
    final requests = ref
        .watch(myRequestsProvider)
        .where(
          (r) =>
              r.status == RequestStatus.pending ||
              r.status == RequestStatus.approved,
        )
        .length;
    return PageBody(
      title: 'Hello, ${user?.displayName ?? 'there'}.',
      subtitle: 'A little clarity for your next chapter.',
      children: [
        DataState(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  color: const Color(0xFF174F43),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'OUTSTANDING ACROSS YOUR LOANS',
                      style: TextStyle(
                        color: Color(0xFFBAD5C3),
                        fontSize: 11,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      money(balance),
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${active.length} active loans · $requests open requests',
                      style: const TextStyle(color: Color(0xFFD6E7DA)),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.tonalIcon(
                      onPressed: () => context.go('/offers'),
                      icon: const Icon(Icons.arrow_outward),
                      label: const Text('Explore offers'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const SectionTitle('Your active loans'),
              if (active.isEmpty)
                const EmptyMessage(
                  title: 'A fresh start',
                  message: 'Browse offers or publish your own. Confirmed loans will appear here.',
                ),
              for (final loan in active)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Panel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.account_balance_wallet_outlined,
                              color: Color(0xFF176B58),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                loan.id == 'loan-demo'
                                    ? 'Community loan'
                                    : 'Peer loan',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            StatusPill(
                              loan.borrowerId == user?.id
                                  ? 'Borrowing'
                                  : 'Lending',
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text(
                          '${money(loanBalance(loan, repayments))} remaining',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${loan.termsSnapshot.termMonths} monthly instalments · ${loan.termsSnapshot.annualRateBps / 100}% annual',
                        ),
                        const SizedBox(height: 14),
                        OutlinedButton(
                          onPressed: () => context.push('/loans/${loan.id}'),
                          child: const Text('View loan'),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              const SectionTitle('Completed history'),
              if (completed.isEmpty)
                const Panel(
                  child: Text(
                    'Fully repaid loans will appear here once all repayments are confirmed.',
                  ),
                ),
              for (final loan in completed)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Panel(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(money(loan.termsSnapshot.principalMinor)),
                      subtitle: const Text('Fully repaid'),
                      trailing: const Icon(Icons.check_circle_outline),
                      onTap: () => context.push('/loans/${loan.id}'),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
