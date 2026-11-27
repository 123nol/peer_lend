import '../../features/auth/presentation/auth_controller.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../../features/explanations/presentation/explanation_screen.dart';
import '../../features/loans/presentation/home_screen.dart';
import '../../features/loans/presentation/loan_detail_screen.dart';
import '../../features/offers/presentation/offer_detail_screen.dart';
import '../../features/offers/presentation/offer_form_screen.dart';
import '../../features/offers/presentation/offer_list_screen.dart';
import '../../features/repayments/presentation/repayment_form_screen.dart';
import '../../features/requests/presentation/requests_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../providers/demo_mode.dart';
import '../widgets/ui.dart';
import 'auth_routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(authProvider, (_, next) => refresh.value++);
  final router = GoRouter(
    initialLocation: '/home',
    refreshListenable: refresh,
    redirect: (context, state) {
      final signedIn = ref.read(authProvider) != null;
      final authRoute = AuthRoute.matches(state.uri.path);
      if (!signedIn && !authRoute) {
        return AuthRoute.signIn.location(returnTo: state.uri.toString());
      }
      if (signedIn && authRoute) {
        return safeAuthReturnTo(state.uri.queryParameters['from']) ?? '/home';
      }
      if (state.uri.path == '/') return '/home';
      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: SafeArea(
        child: PageBody(
          title: 'Page not found',
          subtitle: 'That address is not part of PeerLend.',
          children: [
            FilledButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go home'),
            ),
          ],
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: AuthRoute.signIn.path,
        builder: (_, _) => const AuthScreen(),
      ),
      GoRoute(
        path: AuthRoute.register.path,
        builder: (_, _) => const AuthScreen(register: true),
      ),
      GoRoute(
        path: AuthRoute.recovery.path,
        builder: (_, _) => const RecoveryScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) =>
            AppShell(location: state.uri.path, child: child),
        routes: [
          GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
          GoRoute(
            path: '/offers',
            builder: (_, _) => const OfferListScreen(),
            routes: [
              GoRoute(path: 'new', builder: (_, _) => const OfferFormScreen()),
              GoRoute(
                path: ':offerId',
                builder: (_, state) => OfferDetailScreen(
                  offerId: state.pathParameters['offerId']!,
                ),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (_, state) => OfferFormScreen(
                      offerId: state.pathParameters['offerId']!,
                    ),
                  ),
                  GoRoute(
                    path: 'explanation',
                    builder: (_, state) => ExplanationScreen(
                      offerId: state.pathParameters['offerId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(path: '/requests', builder: (_, _) => const RequestsScreen()),
          GoRoute(
            path: '/loans/:loanId',
            builder: (_, state) =>
                LoanDetailScreen(loanId: state.pathParameters['loanId']!),
            routes: [
              GoRoute(
                path: 'repayments/new',
                builder: (_, state) => RepaymentFormScreen(
                  loanId: state.pathParameters['loanId']!,
                ),
              ),
            ],
          ),
          GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen()),
        ],
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
});

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.location, required this.child});
  final String location;
  final Widget child;
  static const _paths = ['/home', '/offers', '/requests', '/settings'];
  static const _labels = ['Home', 'Offers', 'Requests', 'Settings'];
  static const _icons = [
    Icons.grid_view_outlined,
    Icons.explore_outlined,
    Icons.swap_horiz,
    Icons.tune,
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = location.startsWith('/offers')
        ? 1
        : location.startsWith('/requests')
        ? 2
        : location.startsWith('/settings')
        ? 3
        : 0;
    final wide = MediaQuery.sizeOf(context).width >= 800;
    final demoMode = ref.watch(demoModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.handshake_outlined),
            SizedBox(width: 10),
            Flexible(
              child: Text(
                'PeerLend',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.7,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: demoMode == DemoMode.normal
                ? StatusPill(wide ? 'CLASSROOM DEMO' : 'DEMO')
                : StatusPill('Demo: ${demoMode.name}', emphasized: true),
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            if (wide)
              NavigationRail(
                selectedIndex: index,
                labelType: NavigationRailLabelType.all,
                onDestinationSelected: (i) => context.go(_paths[i]),
                destinations: [
                  for (var i = 0; i < _paths.length; i++)
                    NavigationRailDestination(
                      icon: Icon(_icons[i]),
                      label: Text(_labels[i]),
                    ),
                ],
              ),
            if (wide) const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      ),
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (i) => context.go(_paths[i]),
              destinations: [
                for (var i = 0; i < _paths.length; i++)
                  NavigationDestination(
                    icon: Icon(_icons[i]),
                    label: _labels[i],
                  ),
              ],
            ),
    );
  }
}
