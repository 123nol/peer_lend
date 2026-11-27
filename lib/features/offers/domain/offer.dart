import 'package:freezed_annotation/freezed_annotation.dart';
part 'offer.freezed.dart';

enum OfferStatus { available, reserved, funded }

@freezed
abstract class LoanTerms with _$LoanTerms {
  const factory LoanTerms({
    required int principalMinor,
    required int annualRateBps,
    required int termMonths,
    @Default('ETB') String currency,
  }) = _LoanTerms;
}

@freezed
abstract class Offer with _$Offer {
  const factory Offer({
    required String id,
    required String lenderId,
    required String lenderName,
    required LoanTerms terms,
    @Default(OfferStatus.available) OfferStatus status,
    @Default(1) int version,
  }) = _Offer;
}
