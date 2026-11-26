import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peer_lend/main.dart';

void main() {
  testWidgets('app starts at the demo sign-in screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: PeerLendApp()));
    await tester.pumpAndSettle();
    expect(find.text('PeerLend'), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
  });
}
