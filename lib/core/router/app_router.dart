import '../../features/auth/presentation/auth_controller.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../widgets/ui.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(authProvider, (_, _) => refresh.value++);
  final router = GoRouter(
    initialLocation: '/sign-in',
    refreshListenable: refresh,
    redirect: (_, state) {
      final signedIn = ref.read(authProvider) != null;
      final path = state.uri.path;
      final authRoute = switch (path) {
        '/sign-in' || '/register' || '/recovery' => true,
        _ => false,
      };
      if (path == '/' || (signedIn && authRoute)) {
        return signedIn ? '/account' : '/sign-in';
      }
      if (!signedIn && !authRoute) return '/sign-in';
      return null;
    },
    routes: [
      GoRoute(path: '/sign-in', builder: (_, _) => const AuthScreen()),
      GoRoute(
        path: '/register',
        builder: (_, _) => const AuthScreen(register: true),
      ),
      GoRoute(path: '/recovery', builder: (_, _) => const RecoveryScreen()),
      GoRoute(path: '/account', builder: (_, _) => const DemoAccountScreen()),
    ],
    errorBuilder: (context, _) => Scaffold(
      body: SafeArea(
        child: PageBody(
          title: 'Page not found',
          subtitle: 'That address is not part of PeerLend yet.',
          children: [
            FilledButton(
              onPressed: () => context.go('/account'),
              child: const Text('Back to account'),
            ),
          ],
        ),
      ),
    ),
  );
  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
});
