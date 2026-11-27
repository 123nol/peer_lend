import 'package:freezed_annotation/freezed_annotation.dart';
part 'repayment.freezed.dart';

enum ConfirmationStatus { pending, confirmed }

@freezed
abstract class Repayment with _$Repayment {
  const factory Repayment({
    required String id,
    required String loanId,
    required String instalmentId,
    required int amountMinor,
    required String recordedBy,
    required DateTime recordedAt,
    @Default(ConfirmationStatus.pending) ConfirmationStatus status,
    @Default('') String note,
    @Default(false) bool hasDemoReceipt,
  }) = _Repayment;
}
