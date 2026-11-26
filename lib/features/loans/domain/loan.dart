import 'package:freezed_annotation/freezed_annotation.dart';

import '../../offers/domain/offer.dart';
part 'loan.freezed.dart';

@freezed
abstract class Instalment with _$Instalment {
  const factory Instalment({
    required String id,
    required DateTime dueDate,
    required int amountMinor,
  }) = _Instalment;
}

// Classic Freezed syntax lets us defensively copy the schedule at construction.
@freezed
class Loan with _$Loan {
  Loan({
    required this.id,
    required this.requestId,
    required this.lenderId,
    required this.borrowerId,
    required this.termsSnapshot,
    required this.startDate,
    required List<Instalment> instalments,
  }) : instalments = List.unmodifiable(instalments);

  @override
  final String id;
  @override
  final String requestId;
  @override
  final String lenderId;
  @override
  final String borrowerId;
  @override
  final LoanTerms termsSnapshot;
  @override
  final DateTime startDate;
  @override
  final List<Instalment> instalments;
}
