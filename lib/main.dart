import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() => runApp(const ProviderScope(child: PeerLendApp()));

class PeerLendApp extends ConsumerWidget {
  const PeerLendApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    title: 'PeerLend',
    debugShowCheckedModeBanner: false,
    theme: buildTheme(),
    routerConfig: ref.watch(routerProvider),
  );
}
