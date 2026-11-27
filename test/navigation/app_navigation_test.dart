import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peer_lend/core/providers/demo_mode.dart';
import 'package:peer_lend/core/router/app_router.dart';
import 'package:peer_lend/core/router/auth_routes.dart';
import 'package:peer_lend/features/auth/presentation/auth_controller.dart';
import 'package:peer_lend/features/settings/presentation/preferences_controller.dart';
import 'package:peer_lend/main.dart';

void main() {
  Future<ProviderContainer> start(
    WidgetTester tester, {
    bool signedIn = true,
    double width = 390,
  }) async {
    tester.view.physicalSize = Size(width, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final container = ProviderContainer();
    addTearDown(container.dispose);
    if (signedIn) {
      container
          .read(authProvider.notifier)
          .signIn('abel@demo.test', 'demo1234');
    }
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const PeerLendApp(),
      ),
    );
    await tester.pumpAndSettle();
    return container;
  }

  Future<void> tap(WidgetTester tester, String label) async {
    final control = find.text(label);
    await tester.ensureVisible(control);
    await tester.tap(control);
    await tester.pumpAndSettle();
  }

  testWidgets('every proposed screen is reachable on a phone', (tester) async {
    final container = await start(tester);
    final router = container.read(routerProvider);
    final routes = {
      '/home': 'Hello, Abel.',
      '/offers': 'Find your next step.',
      '/offers/new': 'Make an offer.',
      '/offers/offer-1': 'A closer look.',
      '/offers/offer-1/explanation': 'Understand the numbers.',
      '/requests': 'A shared decision.',
      '/loans/loan-demo': 'Every step, in view.',
      '/loans/loan-demo/repayments/new': 'Record a repayment.',
      '/settings': 'Make yourself at home.',
    };
    for (final entry in routes.entries) {
      router.go(entry.key);
      await tester.pumpAndSettle();
      expect(find.text(entry.value), findsOneWidget, reason: entry.key);
      expect(tester.takeException(), isNull, reason: entry.key);
    }
    container.read(authProvider.notifier).signIn('sara@demo.test', 'demo1234');
    router.go('/offers/offer-1/edit');
    await tester.pumpAndSettle();
    expect(find.text('Edit your offer.'), findsOneWidget);
  });
  testWidgets('bottom navigation, offer detail and back work by tapping', (
    tester,
  ) async {
    await start(tester);
    await tester.tap(find.text('Offers').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('View offer').first);
    await tester.pumpAndSettle();
    expect(find.text('A closer look.'), findsOneWidget);
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Find your next step.'), findsOneWidget);
    await tester.tap(find.text('Requests').last);
    await tester.pumpAndSettle();
    expect(find.text('No requests yet'), findsOneWidget);
  });
  testWidgets('offer requests lead to Loan Detail after confirmation', (
    tester,
  ) async {
    final container = await start(tester);
    final router = container.read(routerProvider);
    final auth = container.read(authProvider.notifier);
    router.go('/offers/offer-1');
    await tester.pumpAndSettle();
    await tap(tester, 'Send request');
    expect(find.text('A shared decision.'), findsOneWidget);

    auth.signIn('sara@demo.test', 'demo1234');
    await tester.pumpAndSettle();
    await tap(tester, 'Approve');

    auth.signIn('abel@demo.test', 'demo1234');
    await tester.pumpAndSettle();
    await tap(tester, 'Confirm terms & create loan');
    expect(find.text('Every step, in view.'), findsOneWidget);
    expect(find.text('Total repayment: 1030.00 ETB'), findsOneWidget);
  });
  testWidgets('deep link survives sign-in and logout protects records', (
    tester,
  ) async {
    final container = await start(tester, signedIn: false);
    final router = container.read(routerProvider);
    router.go('/loans/loan-demo');
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    container.read(authProvider.notifier).signIn('abel@demo.test', 'demo1234');
    await tester.pumpAndSettle();
    expect(find.text('Every step, in view.'), findsOneWidget);
    container.read(authProvider.notifier).signOut();
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Every step, in view.'), findsNothing);
  });
  testWidgets('auth links keep a requested offer through recovery and signup', (
    tester,
  ) async {
    final container = await start(tester, signedIn: false);
    final router = container.read(routerProvider);
    const destination = '/offers/offer-1?source=demo';
    router.go(destination);
    await tester.pumpAndSettle();

    await tap(tester, 'Forgot password?');
    expect(find.text('Account recovery'), findsOneWidget);
    await tap(tester, 'Back');
    await tap(tester, 'Create a demo account');
    expect(find.text('Create your demo account'), findsOneWidget);
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Demo tester');
    await tester.enterText(fields.at(1), 'tester@demo.test');
    await tester.enterText(fields.at(2), 'demopass123');
    await tap(tester, 'Create account');

    expect(find.text('A closer look.'), findsOneWidget);
    expect(router.routeInformationProvider.value.uri.toString(), destination);
  });

  testWidgets('direct recovery link keeps the destination with no back stack', (
    tester,
  ) async {
    final container = await start(tester, signedIn: false);
    final router = container.read(routerProvider);
    const destination = '/loans/loan-demo';
    router.go(AuthRoute.recovery.location(returnTo: destination));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Continue as Abel'));
    await tester.tap(find.text('Continue as Abel'));
    await tester.pumpAndSettle();

    expect(find.text('Every step, in view.'), findsOneWidget);
    expect(router.routeInformationProvider.value.uri.path, destination);
  });

  test('auth return destination excludes external and auth paths', () {
    for (final target in [
      'https://example.com/',
      '//example.com/',
      '/%2fexample.com/',
      '/%5cexample.com/',
      '/recovery/?from=/home',
      '/offers/%FF',
    ]) {
      expect(safeAuthReturnTo(target), isNull, reason: target);
    }
    expect(
      safeAuthReturnTo('/offers/offer-1?source=demo#terms'),
      '/offers/offer-1?source=demo#terms',
    );
  });

  testWidgets('register and recovery screens are reachable', (tester) async {
    final container = await start(tester, signedIn: false);
    container.read(routerProvider).go('/register');
    await tester.pumpAndSettle();
    expect(find.text('Create your demo account'), findsOneWidget);
    container.read(routerProvider).go('/recovery');
    await tester.pumpAndSettle();
    expect(find.text('Account recovery'), findsOneWidget);
  });
  testWidgets(
    'invalid IDs and unauthorized edit routes show a recovery screen',
    (tester) async {
      final container = await start(tester);
      for (final path in [
        '/offers/missing',
        '/loans/missing',
        '/offers/offer-1/edit',
      ]) {
        container.read(routerProvider).go(path);
        await tester.pumpAndSettle();
        expect(find.text('Record unavailable'), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
      container.read(routerProvider).go('/not-a-route');
      await tester.pumpAndSettle();
      expect(find.text('Page not found'), findsOneWidget);
    },
  );
  testWidgets('new user cannot view another participant loan by URL', (
    tester,
  ) async {
    final container = await start(tester);
    container
        .read(authProvider.notifier)
        .register('Other', 'other@demo.test', 'password123');
    container.read(routerProvider).go('/loans/loan-demo');
    await tester.pumpAndSettle();
    expect(find.text('Record unavailable'), findsOneWidget);
  });
  testWidgets('empty, error, loading and offline previews render', (
    tester,
  ) async {
    final container = await start(tester);
    container.read(demoModeProvider.notifier).setMode(DemoMode.empty);
    await tester.pumpAndSettle();
    expect(find.text('No records yet'), findsOneWidget);
    container.read(demoModeProvider.notifier).setMode(DemoMode.error);
    await tester.pumpAndSettle();
    expect(find.text('Could not load records'), findsOneWidget);
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(find.text('Your active loans'), findsOneWidget);
    container.read(demoModeProvider.notifier).setMode(DemoMode.loading);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    container.read(demoModeProvider.notifier).setMode(DemoMode.offline);
    await tester.pumpAndSettle();
    expect(find.textContaining('Offline preview'), findsOneWidget);
    expect(find.text('Demo: offline'), findsOneWidget);
    await tester.tap(find.text('Offers').last);
    await tester.pumpAndSettle();
    expect(find.text('Demo: offline'), findsOneWidget);
    container.read(demoModeProvider.notifier).setMode(DemoMode.normal);
    await tester.pumpAndSettle();
    expect(find.text('Demo: offline'), findsNothing);
    expect(find.text('DEMO'), findsOneWidget);
  });
  testWidgets('explanation is shown only after consent', (tester) async {
    final container = await start(tester);
    container.read(routerProvider).go('/offers/offer-1');
    await tester.pumpAndSettle();
    await tap(tester, 'Explain these terms');
    expect(find.text('Understand the numbers.'), findsOneWidget);
    expect(find.textContaining('That adds 30.00'), findsNothing);
    container.read(preferencesProvider.notifier).update(aiConsent: true);
    await tester.pumpAndSettle();
    expect(find.textContaining('That adds 30.00'), findsOneWidget);
    container.read(preferencesProvider.notifier).update(aiConsent: false);
    await tester.pumpAndSettle();
    expect(find.textContaining('That adds 30.00'), findsNothing);
  });
  testWidgets('offer creation validates and updates the browsable detail', (
    tester,
  ) async {
    final container = await start(tester);
    container.read(routerProvider).go('/offers/new');
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Publish offer'));
    await tester.tap(find.text('Publish offer'));
    await tester.pumpAndSettle();
    expect(find.text('Enter an amount from 1 to 1,000,000'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(0), '700');
    await tester.ensureVisible(find.text('Publish offer'));
    await tester.tap(find.text('Publish offer'));
    await tester.pumpAndSettle();
    expect(find.text('A closer look.'), findsOneWidget);
    expect(find.text('700.00 ETB'), findsOneWidget);
  });
  testWidgets('small phone with enlarged text has no layout exceptions', (
    tester,
  ) async {
    tester.platformDispatcher.textScaleFactorTestValue = 1.4;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final container = await start(tester, width: 320);
    for (final path in [
      '/home',
      '/offers',
      '/requests',
      '/settings',
      '/offers/offer-1',
      '/loans/loan-demo',
      '/loans/loan-demo/repayments/new',
    ]) {
      container.read(routerProvider).go(path);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: path);
    }
  });
  testWidgets('wide screen uses the navigation rail', (tester) async {
    await start(tester, width: 1280);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });
}
