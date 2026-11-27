import '../../../core/widgets/ui.dart';
import '../../auth/presentation/auth_controller.dart';
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
              if (offer.status == OfferStatus.available && own) ...[
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilledButton(
                    onPressed: () => context.push('/offers/$offerId/edit'),
                    child: const Text('Edit offer'),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              const SectionTitle('Repayment preview'),
              SchedulePreview(terms: offer.terms),
            ],
          ),
        ),
      ],
    );
  }
}
