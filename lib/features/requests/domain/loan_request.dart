import 'package:freezed_annotation/freezed_annotation.dart';

import '../../offers/domain/offer.dart';
part 'loan_request.freezed.dart';

enum RequestStatus { pending, approved, declined, confirmed }

@freezed
abstract class LoanRequest with _$LoanRequest {
  const factory LoanRequest({
    required String id,
    required String offerId,
    required String lenderId,
    required String borrowerId,
    required String borrowerName,
    required LoanTerms termsSnapshot,
    required DateTime createdAt,
    @Default(RequestStatus.pending) RequestStatus status,
  }) = _LoanRequest;
}
