import '../domain/offer.dart';
import '../domain/offer_repository.dart';

class InMemoryOfferRepository implements OfferRepository {
  final Map<String, Offer> _offers = {
    'offer-1': const Offer(
      id: 'offer-1',
      lenderId: 'lender',
      lenderName: 'Sara',
      terms: LoanTerms(
        principalMinor: 100000,
        annualRateBps: 1200,
        termMonths: 3,
      ),
    ),
    'offer-2': const Offer(
      id: 'offer-2',
      lenderId: 'lender',
      lenderName: 'Sara',
      terms: LoanTerms(principalMinor: 50000, annualRateBps: 0, termMonths: 2),
    ),
    'offer-3': const Offer(
      id: 'offer-3',
      lenderId: 'community',
      lenderName: 'Dawit',
      terms: LoanTerms(
        principalMinor: 250000,
        annualRateBps: 800,
        termMonths: 6,
      ),
    ),
  };
  @override
  List<Offer> getAll() => List.unmodifiable(_offers.values);
  @override
  void save(Offer offer) => _offers[offer.id] = offer;
}
