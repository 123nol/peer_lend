import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:peer_lend/core/router/app_router.dart';
import 'package:peer_lend/features/auth/presentation/auth_controller.dart';
import 'package:peer_lend/features/repayments/domain/repayment.dart';
import 'package:peer_lend/features/repayments/presentation/repayment_controller.dart';
import 'package:peer_lend/main.dart';

void main() {
  const route = '/loans/loan-demo/repayments/new';
  const loanRoute = '/loans/loan-demo';
  final amount = find.widgetWithText(TextFormField, 'Amount (ETB)');
  final date = find.widgetWithText(TextFormField, 'Payment date');
  final note = find.widgetWithText(
    TextFormField,
    'Private receipt note (optional)',
  );
  final attach = find.text('Attach sample receipt');

  Future<ProviderContainer> open(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(authProvider.notifier).signIn('abel@demo.test', 'demo1234');
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const PeerLendApp(),
      ),
    );
    container.read(routerProvider).go(route);
    await tester.pumpAndSettle();
    return container;
  }

  Future<void> fill(WidgetTester tester) async {
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('343.33 ETB').hitTestable().first);
    await tester.pumpAndSettle();
    await tester.enterText(amount, '12.34');
    await tester.pump();
    await tester.ensureVisible(date);
    await tester.enterText(date, '2025-01-01');
    await tester.pump();
    await tester.ensureVisible(note);
    await tester.enterText(note, 'Sample repayment');
    await tester.pump();
    await tester.ensureVisible(attach);
    await tester.tap(attach);
    await tester.pumpAndSettle();
  }

  testWidgets('draft values reach the in-memory repayment record', (
    tester,
  ) async {
    final container = await open(tester);
    await fill(tester);
    expect(find.text('SAMPLE RECEIPT · FICTIONAL'), findsOneWidget);

    final save = find.text('Save repayment record');
    await tester.ensureVisible(save);
    await tester.tap(save);
    await tester.pumpAndSettle();

    final item = container
        .read(repaymentsProvider)
        .singleWhere((item) => item.id != 'repayment-demo');
    expect(item.loanId, 'loan-demo');
    expect(item.instalmentId, 'demo-1');
    expect(item.amountMinor, 1234);
    expect(item.recordedAt, DateTime(2025, 1, 1));
    expect(item.note, 'Sample repayment');
    expect(item.hasDemoReceipt, isTrue);
    expect(item.status, ConfirmationStatus.pending);
    expect(find.text('Every step, in view.'), findsOneWidget);
  });

  testWidgets('leaving the form discards the unsaved draft', (tester) async {
    final container = await open(tester);
    await fill(tester);
    final router = container.read(routerProvider);
    router.go(loanRoute);
    await tester.pumpAndSettle();
    router.go(route);
    await tester.pumpAndSettle();

    expect(find.text('12.34'), findsNothing);
    expect(find.text('2025-01-01'), findsNothing);
    expect(find.text('Sample repayment'), findsNothing);
    expect(find.text('SAMPLE RECEIPT · FICTIONAL'), findsNothing);
    expect(
      tester
          .state<FormFieldState<String>>(
            find.byType(DropdownButtonFormField<String>),
          )
          .value,
      isNull,
    );
    expect(container.read(repaymentsProvider).single.id, 'repayment-demo');
  });
}
