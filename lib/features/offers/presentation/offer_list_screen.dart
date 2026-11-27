import '../../../core/widgets/ui.dart';
import '../../auth/presentation/auth_controller.dart';
import '../domain/offer.dart';
import '../domain/repayment_calculator.dart';
import 'offer_controller.dart';

class OfferListScreen extends ConsumerWidget {
  const OfferListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interestFree = ref.watch(offerFilterProvider);
    final user = ref.watch(authProvider);
    final offers = ref
        .watch(offersProvider)
        .where(
          (o) =>
              (o.status == OfferStatus.available || o.lenderId == user?.id) &&
              (!interestFree || o.terms.annualRateBps == 0),
        )
        .toList();
    return PageBody(
      title: 'Find your next step.',
      subtitle:
          'Explore clear terms from your community. All amounts are fictional.',
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            FilledButton.icon(
              onPressed: () => context.push('/offers/new'),
              icon: const Icon(Icons.add),
              label: const Text('Create offer'),
            ),
            FilterChip(
              label: const Text('Interest-free only'),
              selected: interestFree,
              onSelected: ref
                  .read(offerFilterProvider.notifier)
                  .setInterestFree,
            ),
          ],
        ),
        const SizedBox(height: 24),
        DataState(
          child: offers.isEmpty
              ? const EmptyMessage(
                  title: 'No matching offers',
                  message: 'Try another filter or create an offer.',
                )
              : LayoutBuilder(
                  builder: (context, constraints) => Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      for (final offer in offers)
                        SizedBox(
                          width: constraints.maxWidth > 650
                              ? (constraints.maxWidth - 16) / 2
                              : constraints.maxWidth,
                          child: Panel(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xFFE8F1E8),
                                      child: Text(
                                        offer.lenderName.substring(0, 1),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        offer.lenderId == user?.id
                                            ? 'Your offer'
                                            : 'From ${offer.lenderName}',
                                      ),
                                    ),
                                    StatusPill(offer.status.name),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  money(offer.terms.principalMinor),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${offer.terms.annualRateBps / 100}% annual · ${offer.terms.termMonths} months',
                                ),
                                const Divider(),
                                Text(
                                  'Total ${money(RepaymentCalculator.total(offer.terms))}',
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        context.push('/offers/${offer.id}'),
                                    child: const Text('View offer'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
