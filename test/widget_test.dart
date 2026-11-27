import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peer_lend/core/router/app_router.dart';
import 'package:peer_lend/main.dart';

void main() {
  Future<ProviderContainer> start(WidgetTester tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const PeerLendApp(),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  Future<void> tap(WidgetTester tester, String title) async {
    final control = find.text(title);
    await tester.ensureVisible(control);
    await tester.tap(control);
    await tester.pumpAndSettle();
  }

  testWidgets('app starts at the demo sign-in screen', (tester) async {
    await start(tester);
    expect(find.text('PeerLend'), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
  });

  testWidgets('quick demo sign-in and sign-out update the route', (
    tester,
  ) async {
    await start(tester);
    await tap(tester, 'Continue as Abel');
    expect(find.text('Hello, Abel.'), findsOneWidget);
    await tap(tester, 'Sign out');
    expect(find.text('Welcome back'), findsOneWidget);
  });

  testWidgets('signed-out visitors cannot open the account directly', (
    tester,
  ) async {
    final container = await start(tester);
    container.read(routerProvider).go('/account');
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign out'), findsNothing);
  });

  testWidgets('a fictional account can be registered and used', (tester) async {
    await start(tester);
    await tap(tester, 'Create a demo account');
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Miki');
    await tester.enterText(fields.at(1), 'miki@demo.test');
    await tester.enterText(fields.at(2), 'demopass123');
    await tap(tester, 'Create account');
    expect(find.text('Hello, Miki.'), findsOneWidget);
  });

  testWidgets('recovery explains the demo and returns to sign-in', (
    tester,
  ) async {
    await start(tester);
    await tap(tester, 'Forgot password?');
    expect(find.text('Account recovery'), findsOneWidget);
    expect(find.textContaining('No email is sent'), findsOneWidget);
    await tap(tester, 'Back');
    expect(find.text('Welcome back'), findsOneWidget);
  });
}
