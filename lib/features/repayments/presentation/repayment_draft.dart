import 'package:freezed_annotation/freezed_annotation.dart';

part 'repayment_draft.freezed.dart';

@freezed
abstract class RepaymentDraft with _$RepaymentDraft {
  const factory RepaymentDraft({
    String? instalmentId,
    @Default('') String amount,
    required String paymentDate,
    @Default('') String note,
    @Default(false) bool hasDemoReceipt,
  }) = _RepaymentDraft;
}
