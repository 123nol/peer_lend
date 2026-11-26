import '../../../core/widgets/ui.dart';
import '../../loans/presentation/loan_controller.dart';
import 'repayment_controller.dart';

class RepaymentFormScreen extends ConsumerStatefulWidget {
  const RepaymentFormScreen({super.key, required this.loanId});
  final String loanId;
  @override
  ConsumerState<RepaymentFormScreen> createState() =>
      _RepaymentFormScreenState();
}

class _RepaymentFormScreenState extends ConsumerState<RepaymentFormScreen> {
  final _form = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _date = TextEditingController(text: shortDate(DateTime.now()));
  final _note = TextEditingController();
  String? _instalmentId;
  bool _sampleReceipt = false;
  @override
  void dispose() {
    _amount.dispose();
    _date.dispose();
    _note.dispose();
    super.dispose();
  }

  DateTime? _parsedDate() {
    final parsed = DateTime.tryParse(_date.text);
    return parsed != null && shortDate(parsed) == _date.text ? parsed : null;
  }

  @override
  Widget build(BuildContext context) {
    final loan = ref
        .watch(myLoansProvider)
        .where((l) => l.id == widget.loanId)
        .firstOrNull;
    if (loan == null) return const MissingRecord();
    final repayments = ref.watch(repaymentsProvider);
    final available = loan.instalments
        .where(
          (i) =>
              repayments
                  .where((r) => r.instalmentId == i.id)
                  .fold(0, (sum, r) => sum + r.amountMinor) <
              i.amountMinor,
        )
        .toList();
    return PageBody(
      title: 'Record a repayment.',
      subtitle: 'The other participant will confirm this record.',
      back: '/loans/${widget.loanId}',
      children: [
        if (available.isEmpty)
          const EmptyMessage(
            title: 'Everything is recorded',
            message: 'All instalments are paid or awaiting confirmation.',
          )
        else
          Panel(
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _instalmentId,
                    isExpanded: true,
                    decoration: const InputDecoration(labelText: 'Instalment'),
                    items: [
                      for (final item in available)
                        DropdownMenuItem(
                          value: item.id,
                          child: Text(
                            '${shortDate(item.dueDate)} · ${money(item.amountMinor)}',
                          ),
                        ),
                    ],
                    onChanged: (v) => setState(() {
                      _instalmentId = v;
                    }),
                    validator: (v) => v == null ? 'Choose an instalment' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _amount,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Amount (ETB)',
                    ),
                    validator: (v) => (parseMinor(v ?? '') ?? 0) <= 0
                        ? 'Enter a positive amount with at most two decimals'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _date,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: 'Payment date',
                      hintText: 'YYYY-MM-DD',
                    ),
                    validator: (_) {
                      final date = _parsedDate();
                      return date == null ||
                              date.isBefore(DateTime(2000)) ||
                              date.isAfter(DateTime.now())
                          ? 'Enter a valid past or current date: YYYY-MM-DD'
                          : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _note,
                    maxLines: 3,
                    maxLength: 300,
                    decoration: const InputDecoration(
                      labelText: 'Private receipt note (optional)',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const SectionTitle('Receipt camera'),
                  const Text(
                    'Camera preview is simulated for Milestone 1. You can attach a sample receipt or keep a typed note. No photo is captured or saved.',
                  ),
                  const SizedBox(height: 12),
                  if (_sampleReceipt)
                    Container(
                      padding: const EdgeInsets.all(24),
                      color: const Color(0xFFF1F4EA),
                      child: const Column(
                        children: [
                          Icon(Icons.receipt_long_outlined, size: 40),
                          SizedBox(height: 8),
                          Text('SAMPLE RECEIPT · FICTIONAL'),
                          Text('For classroom demonstration only'),
                        ],
                      ),
                    ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => setState(() {
                          _sampleReceipt = !_sampleReceipt;
                        }),
                        icon: Icon(
                          _sampleReceipt
                              ? Icons.delete_outline
                              : Icons.camera_alt_outlined,
                        ),
                        label: Text(
                          _sampleReceipt
                              ? 'Remove sample receipt'
                              : 'Attach sample receipt',
                        ),
                      ),
                      TextButton(
                        onPressed: () => notify(
                          context,
                          'Camera access denied (simulation). Use the typed note instead.',
                        ),
                        child: const Text('Simulate permission denial'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {
                      if (!_form.currentState!.validate()) return;
                      perform(context, () {
                        ref
                            .read(repaymentsProvider.notifier)
                            .record(
                              loanId: loan.id,
                              instalmentId: _instalmentId!,
                              amountMinor: parseMinor(_amount.text)!,
                              date: _parsedDate()!,
                              note: _note.text,
                              hasDemoReceipt: _sampleReceipt,
                            );
                        context.go('/loans/${loan.id}');
                      }, success: 'Repayment recorded. Awaiting confirmation.');
                    },
                    child: const Text('Save repayment record'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
