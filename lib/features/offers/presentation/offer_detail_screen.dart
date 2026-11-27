import '../../../core/widgets/ui.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../requests/presentation/request_controller.dart';
import '../domain/offer.dart';
import 'offer_controller.dart';
import 'offer_widgets.dart';

class OfferDetailScreen extends ConsumerWidget {
  const OfferDetailScreen({super.key, required this.offerId});
  final String offerId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offer = ref
        .watch(offersProvider)
        .where((o) => o.id == offerId)
        .firstOrNull;
    if (offer == null) return const MissingRecord(back: '/offers');
    final own = offer.lenderId == ref.watch(authProvider)?.id;
    return PageBody(
      title: 'A closer look.',
      subtitle: 'Offer from ${offer.lenderName} · ${offer.status.name}',
      back: '/offers',
      children: [
        DataState(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TermsPanel(terms: offer.terms),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  if (offer.status == OfferStatus.available && !own)
                    FilledButton.icon(
                      onPressed: () => perform(
                        context,
                        () {
                          ref.read(requestsProvider.notifier).send(offerId);
                          context.go('/requests');
                        },
                        success:
                            'Request sent. The lender will review your terms.',
                      ),
                      icon: const Icon(Icons.arrow_outward),
                      label: const Text('Send request'),
                    ),
                  if (offer.status == OfferStatus.available && own)
                    FilledButton(
                      onPressed: () => context.push('/offers/$offerId/edit'),
                      child: const Text('Edit offer'),
                    ),
                  OutlinedButton.icon(
                    onPressed: () =>
                        context.push('/offers/$offerId/explanation'),
                    icon: const Icon(Icons.auto_awesome_outlined),
                    label: const Text('Explain these terms'),
                  ),
                ],
              ),
              if (own)
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'This is your offer. Other participants can request it.',
                  ),
                ),
              const SizedBox(height: 24),
              const SectionTitle('Repayment preview'),
              SchedulePreview(terms: offer.terms),
              const SizedBox(height: 16),
              const Text(
                'A request is followed by lender approval and your confirmation of the same terms. No money moves in this prototype.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
