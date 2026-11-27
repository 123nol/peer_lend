import '../../../core/widgets/ui.dart';
import '../../offers/presentation/offer_controller.dart';
import '../../offers/presentation/offer_widgets.dart';
import '../../settings/presentation/preferences_controller.dart';
import 'explanation_controller.dart';

class ExplanationScreen extends ConsumerWidget {
  const ExplanationScreen({super.key, required this.offerId});
  final String offerId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offer = ref
        .watch(offersProvider)
        .where((o) => o.id == offerId)
        .firstOrNull;
    if (offer == null) return const MissingRecord(back: '/offers');
    final consent = ref.watch(preferencesProvider).aiConsent;
    return PageBody(
      title: 'Understand the numbers.',
      subtitle: 'AI explanation preview · Local simulation',
      back: '/offers/$offerId',
      children: [
        DataState(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TermsPanel(terms: offer.terms),
              const SizedBox(height: 24),
              Panel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.auto_awesome_outlined,
                      color: Color(0xFF176B58),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'This milestone uses a fixed educational explanation. Nothing is sent to an AI provider. A later integration will use only fictional terms after consent.',
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Allow example explanations'),
                      subtitle: const Text(
                        'You can withdraw this preference in Settings.',
                      ),
                      value: consent,
                      onChanged: (v) => ref
                          .read(preferencesProvider.notifier)
                          .update(aiConsent: v),
                    ),
                    if (consent) ...[
                      const Divider(),
                      ref
                          .watch(explanationProvider(offerId))
                          .when(
                            data: (text) =>
                                Text(text, style: const TextStyle(height: 1.7)),
                            loading: () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            error: (e, st) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Explanation unavailable. Simple interest = principal × annual rate × months / 12. The repayment schedule below remains available.',
                                ),
                                TextButton(
                                  onPressed: () => ref.invalidate(
                                    explanationProvider(offerId),
                                  ),
                                  child: const Text('Retry explanation'),
                                ),
                              ],
                            ),
                          ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const SectionTitle('Calculated schedule'),
              SchedulePreview(terms: offer.terms),
              const SizedBox(height: 16),
              const Text(
                'Educational example only. The calculated schedule is authoritative.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
