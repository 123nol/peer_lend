import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/ui.dart' show shortDate;
import 'repayment_draft.dart';

final repaymentDraftProvider = NotifierProvider.autoDispose
    .family<RepaymentDraftController, RepaymentDraft, String>(
      RepaymentDraftController.new,
    );

class RepaymentDraftController extends Notifier<RepaymentDraft> {
  RepaymentDraftController(String _);

  @override
  RepaymentDraft build() =>
      RepaymentDraft(paymentDate: shortDate(DateTime.now()));

  void selectInstalment(String? id) => state = state.copyWith(instalmentId: id);

  void setAmount(String amount) => state = state.copyWith(amount: amount);

  void setPaymentDate(String paymentDate) =>
      state = state.copyWith(paymentDate: paymentDate);

  void setNote(String note) => state = state.copyWith(note: note);

  void toggleDemoReceipt() =>
      state = state.copyWith(hasDemoReceipt: !state.hasDemoReceipt);
}
