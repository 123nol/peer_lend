import '../../../core/widgets/ui.dart';
import '../../auth/presentation/auth_controller.dart';
import '../domain/offer.dart';
import 'offer_controller.dart';

class OfferFormScreen extends ConsumerStatefulWidget {
  const OfferFormScreen({super.key, this.offerId});
  final String? offerId;
  @override
  ConsumerState<OfferFormScreen> createState() => _OfferFormScreenState();
}

class _OfferFormScreenState extends ConsumerState<OfferFormScreen> {
  final _form = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _rate = TextEditingController(text: '0');
  final _months = TextEditingController(text: '3');
  @override
  void initState() {
    super.initState();
    final offer = ref.read(offersProvider.notifier).find(widget.offerId ?? '');
    if (offer != null) {
      _amount.text = (offer.terms.principalMinor / 100).toStringAsFixed(2);
      _rate.text = (offer.terms.annualRateBps / 100).toStringAsFixed(2);
      _months.text = '${offer.terms.termMonths}';
    }
  }

  @override
  void dispose() {
    _amount.dispose();
    _rate.dispose();
    _months.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final existing = ref
        .watch(offersProvider)
        .where((o) => o.id == widget.offerId)
        .firstOrNull;
    if (widget.offerId != null &&
        (existing == null ||
            existing.lenderId != ref.watch(authProvider)?.id ||
            existing.status != OfferStatus.available)) {
      return const MissingRecord(back: '/offers');
    }
    return PageBody(
      title: widget.offerId == null ? 'Make an offer.' : 'Edit your offer.',
      subtitle: 'Set simple, transparent terms for your community.',
      back: '/offers',
      children: [
        Panel(
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _amount,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Principal amount (ETB)',
                    helperText: '1–1,000,000 ETB · up to two decimal places',
                  ),
                  validator: (v) {
                    final n = parseMinor(v ?? '');
                    return n == null || n < 100 || n > 100000000
                        ? 'Enter an amount from 1 to 1,000,000'
                        : null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _rate,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Annual interest rate (%)',
                    helperText: 'Simple interest, from 0% to 100%',
                  ),
                  validator: (v) {
                    final n = parseMinor(v ?? '');
                    return n == null || n > 10000
                        ? 'Enter a rate from 0 to 100'
                        : null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _months,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Repayment term (months)',
                    helperText: '1–60 monthly instalments',
                  ),
                  validator: (v) {
                    final n = int.tryParse(v ?? '');
                    return n == null || n < 1 || n > 60
                        ? 'Enter 1 to 60 months'
                        : null;
                  },
                ),
                const SizedBox(height: 28),
                FilledButton(
                  onPressed: () {
                    if (!_form.currentState!.validate()) return;
                    perform(
                      context,
                      () {
                        final id = ref
                            .read(offersProvider.notifier)
                            .publish(
                              LoanTerms(
                                principalMinor: parseMinor(_amount.text)!,
                                annualRateBps: parseMinor(_rate.text)!,
                                termMonths: int.parse(_months.text),
                              ),
                              id: widget.offerId,
                            );
                        context.go('/offers/$id');
                      },
                      success:
                          'Offer saved. Review your repayment preview below.',
                    );
                  },
                  child: Text(
                    widget.offerId == null ? 'Publish offer' : 'Save changes',
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
