import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DemoMode { normal, loading, empty, error, offline }

final demoModeProvider = NotifierProvider<DemoModeController, DemoMode>(
  DemoModeController.new,
);

class DemoModeController extends Notifier<DemoMode> {
  @override
  DemoMode build() => DemoMode.normal;
  void setMode(DemoMode mode) => state = mode;
}

void requireWritable(Ref ref) {
  if (ref.read(demoModeProvider) != DemoMode.normal) {
    throw StateError('Switch the demo data state to Normal to make changes.');
  }
}
