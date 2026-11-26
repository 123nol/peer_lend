import 'package:flutter_test/flutter_test.dart';
import 'package:peer_lend/main.dart';

void main() {
  testWidgets('app starts with the PeerLend identity', (tester) async {
    await tester.pumpWidget(const PeerLendApp());
    expect(find.text('PeerLend'), findsOneWidget);
  });
}
