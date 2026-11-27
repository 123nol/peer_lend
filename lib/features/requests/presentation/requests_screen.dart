import '../../../core/widgets/ui.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../loans/presentation/loan_controller.dart';
import '../../offers/domain/repayment_calculator.dart';
import '../domain/loan_request.dart';
import 'request_controller.dart';

class RequestsScreen extends ConsumerWidget {
  const RequestsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requests = ref.watch(myRequestsProvider);
    final user = ref.watch(authProvider);
    return PageBody(
      title: 'A shared decision.',
      subtitle: 'Request → lender approval → borrower confirmation.',
      children: [
        DataState(
          child: requests.isEmpty
              ? EmptyMessage(
                  title: 'No requests yet',
                  message: 'Requests you send or receive will appear here.',
                  action: FilledButton(
                    onPressed: () => context.go('/offers'),
                    child: const Text('Browse offers'),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final request in requests.reversed)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
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
                                    request.lenderId == user?.id
                                        ? 'From ${request.borrowerName}'
                                        : 'Your request',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  StatusPill(request.status.name),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                money(request.termsSnapshot.principalMinor),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${request.termsSnapshot.annualRateBps / 100}% annual · ${request.termsSnapshot.termMonths} months',
                              ),
                              Text(
                                'Agreed total: ${money(RepaymentCalculator.total(request.termsSnapshot))}',
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Requested ${shortDate(request.createdAt)} · Terms snapshot',
                              ),
                              const SizedBox(height: 20),
                              if (request.status == RequestStatus.pending &&
                                  request.lenderId == user?.id)
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 8,
                                  children: [
                                    FilledButton(
                                      onPressed: () => perform(
                                        context,
                                        () => ref
                                            .read(requestsProvider.notifier)
                                            .decide(request.id, approve: true),
                                        success: 'Approved. Waiting for borrower confirmation.',
                                      ),
                                      child: const Text('Approve'),
                                    ),
                                    OutlinedButton(
                                      onPressed: () => perform(
                                        context,
                                        () => ref
                                            .read(requestsProvider.notifier)
                                            .decide(request.id, approve: false),
                                      ),
                                      child: const Text('Decline'),
                                    ),
                                  ],
                                )
                              else if (request.status ==
                                      RequestStatus.approved &&
                                  request.borrowerId == user?.id)
                                FilledButton(
                                  onPressed: () => perform(context, () {
                                    final loanId = ref
                                        .read(requestsProvider.notifier)
                                        .confirm(request.id);
                                    context.go('/loans/$loanId');
                                  }),
                                  child: const Text(
                                    'Confirm terms & create loan',
                                  ),
                                )
                              else if (request.status ==
                                  RequestStatus.confirmed)
                                OutlinedButton(
                                  onPressed: () {
                                    final loan = ref
                                        .read(loansProvider)
                                        .where((l) => l.requestId == request.id)
                                        .firstOrNull;
                                    if (loan != null) {
                                      context.push('/loans/${loan.id}');
                                    }
                                  },
                                  child: const Text('View confirmed loan'),
                                )
                              else
                                Text(
                                  request.status == RequestStatus.declined
                                      ? 'This request was declined. You can browse other offers.'
                                      : 'Waiting for the other participant.',
                                ),
                            ],
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
