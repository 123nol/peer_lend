import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/demo_mode.dart';

export 'package:flutter/material.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:go_router/go_router.dart';

String money(int minor) => '${(minor / 100).toStringAsFixed(2)} ETB';
String shortDate(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
int? parseMinor(String text) {
  if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(text.trim())) return null;
  final parts = text.trim().split('.');
  final whole = int.tryParse(parts[0]);
  if (whole == null || whole > 1000000000) return null;
  return whole * 100 +
      (parts.length == 1 ? 0 : int.parse(parts[1].padRight(2, '0')));
}

void notify(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void perform(BuildContext context, VoidCallback action, {String? success}) {
  try {
    action();
    if (success != null && context.mounted) notify(context, success);
  } on ArgumentError catch (error) {
    notify(context, '${error.message}');
  } on StateError catch (error) {
    notify(context, error.message);
  }
}

class PageBody extends StatelessWidget {
  const PageBody({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.back,
  });
  final String title;
  final String subtitle;
  final List<Widget> children;
  final String? back;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 960),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (back != null)
              TextButton.icon(
                onPressed: () =>
                    context.canPop() ? context.pop() : context.go(back!),
                icon: const Icon(Icons.arrow_back, size: 18),
                label: const Text('Back'),
              ),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -1),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: const Color(0xFF63736C)),
            ),
            const SizedBox(height: 28),
            ...children,
          ],
        ),
      ),
    ),
  );
}

class Panel extends StatelessWidget {
  const Panel({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(padding: const EdgeInsets.all(22), child: child),
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 16),
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleLarge
          ?.copyWith(fontWeight: FontWeight.w700),
    ),
  );
}

class StatusPill extends StatelessWidget {
  const StatusPill(this.label, {super.key, this.emphasized = false});
  final String label;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: emphasized ? colors.secondaryContainer : const Color(0xFFE8F1E8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: emphasized
              ? colors.onSecondaryContainer
              : const Color(0xFF315C3F),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({
    super.key,
    required this.title,
    required this.message,
    this.action,
  });
  final String title;
  final String message;
  final Widget? action;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Panel(
      child: Column(
        children: [
          const Icon(Icons.inbox_outlined, size: 44, color: Color(0xFF638372)),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          if (action != null) ...[const SizedBox(height: 16), action!],
        ],
      ),
    ),
  );
}

class DataState extends ConsumerWidget {
  const DataState({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(demoModeProvider);
    switch (mode) {
      case DemoMode.loading:
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(48),
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading demo data…'),
              ],
            ),
          ),
        );
      case DemoMode.empty:
        return const EmptyMessage(
          title: 'No records yet',
          message: 'This is the empty-state preview. Change Demo data to Normal in Settings to restore the sample records.',
        );
      case DemoMode.error:
        return EmptyMessage(
          title: 'Could not load records',
          message: 'A simulated error. Your in-memory records are still here.',
          action: FilledButton(
            onPressed: () =>
                ref.read(demoModeProvider.notifier).setMode(DemoMode.normal),
            child: const Text('Try again'),
          ),
        );
      case DemoMode.offline:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Panel(
              child: Text(
                'Offline preview · You can read the current records. Reconnect in Settings to make changes.',
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        );
      case DemoMode.normal:
        return child;
    }
  }
}

class MissingRecord extends StatelessWidget {
  const MissingRecord({super.key, this.back = '/home'});
  final String back;
  @override
  Widget build(BuildContext context) => PageBody(
    title: 'Record unavailable',
    subtitle: 'This record does not exist or is not available to this account.',
    back: back,
    children: const [],
  );
}
