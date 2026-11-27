import 'offer.dart';

/// All calculations use minor currency units. Round interest once, half up.
/// The last instalment absorbs the remainder so the schedule sums exactly.
class RepaymentCalculator {
  static void validate(LoanTerms terms) {
    if (terms.principalMinor < 100 || terms.principalMinor > 100000000) {
      throw ArgumentError('Amount must be between 1 and 1,000,000 ETB.');
    }
    if (terms.annualRateBps < 0 || terms.annualRateBps > 10000) {
      throw ArgumentError('Annual rate must be between 0 and 100%.');
    }
    if (terms.termMonths < 1 || terms.termMonths > 60) {
      throw ArgumentError('Term must be between 1 and 60 months.');
    }
  }

  static int interest(LoanTerms terms) {
    validate(terms);
    return (terms.principalMinor * terms.annualRateBps * terms.termMonths +
            60000) ~/
        120000;
  }

  static int total(LoanTerms terms) => terms.principalMinor + interest(terms);

  static List<int> schedule(LoanTerms terms) {
    final amount = total(terms);
    final regular = amount ~/ terms.termMonths;
    return List.generate(
      terms.termMonths,
      (i) => i == terms.termMonths - 1
          ? amount - regular * (terms.termMonths - 1)
          : regular,
    );
  }
}
