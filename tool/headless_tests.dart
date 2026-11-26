// Optional Linux fallback for environments that disallow localhost sockets.
// The standard milestone command remains `flutter test`.
import 'package:flutter_test/flutter_test.dart';

import '../test/domain/repayment_calculator_test.dart' as domain;
import '../test/navigation/app_navigation_test.dart' as navigation;
import '../test/providers/workflow_test.dart' as providers;
import '../test/widget_test.dart' as smoke;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('domain', domain.main);
  group('providers', providers.main);
  group('navigation', navigation.main);
  group('smoke', smoke.main);
}
