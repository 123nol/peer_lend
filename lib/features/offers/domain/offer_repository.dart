import 'offer.dart';

abstract interface class OfferRepository {
  List<Offer> getAll();
  void save(Offer offer);
}
