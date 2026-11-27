import '../../../core/router/auth_routes.dart';
import '../../../core/widgets/ui.dart';
import 'auth_controller.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key, this.register = false});
  final bool register;
  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    perform(context, () {
      final auth = ref.read(authProvider.notifier);
      if (widget.register) {
        auth.register(_name.text, _email.text, _password.text);
      } else {
        auth.signIn(_email.text, _password.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.handshake_outlined,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  'PeerLend',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Clear terms. Shared understanding.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Panel(
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.register
                              ? 'Create your demo account'
                              : 'Welcome back',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Explore lending with fictional accounts and amounts.',
                        ),
                        const SizedBox(height: 24),
                        if (widget.register) ...[
                          TextFormField(
                            controller: _name,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            ),
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Enter your name'
                                : null,
                          ),
                          const SizedBox(height: 16),
                        ],
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email),
                          ),
                          validator: (v) =>
                              v == null ||
                                  !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                                      .hasMatch(v.trim())
                              ? 'Enter a valid email'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          onFieldSubmitted: (_) => _submit(),
                          validator: (v) => v == null || v.length < 8
                              ? 'Use at least 8 characters'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        FilledButton(
                          onPressed: _submit,
                          child: Text(
                            widget.register ? 'Create account' : 'Sign in',
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go(
                            (widget.register
                                    ? AuthRoute.signIn
                                    : AuthRoute.register)
                                .from(GoRouterState.of(context).uri),
                          ),
                          child: Text(
                            widget.register
                                ? 'Already have an account? Sign in'
                                : 'Create a demo account',
                          ),
                        ),
                        if (!widget.register)
                          TextButton(
                            onPressed: () => context.push(
                              AuthRoute.recovery.from(
                                GoRouterState.of(context).uri,
                              ),
                            ),
                            child: const Text('Forgot password?'),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (!widget.register) ...[
                  const Text(
                    'QUICK DEMO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      OutlinedButton(
                        onPressed: () => ref
                            .read(authProvider.notifier)
                            .signIn('abel@demo.test', 'demo1234'),
                        child: const Text('Continue as Abel'),
                      ),
                      OutlinedButton(
                        onPressed: () => ref
                            .read(authProvider.notifier)
                            .signIn('sara@demo.test', 'demo1234'),
                        child: const Text('Continue as Sara'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                const Text(
                  'Classroom prototype · No real money\nData resets when the app restarts.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF63736C), fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class RecoveryScreen extends StatelessWidget {
  const RecoveryScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: PageBody(
        title: 'Account recovery',
        subtitle: 'Demo account help',
        back: AuthRoute.signIn.from(GoRouterState.of(context).uri),
        children: const [
          Panel(
            child: Text(
              'Email recovery will be connected to authentication in Milestone 2. No email is sent in this demo.\n\nUse abel@demo.test or sara@demo.test with password demo1234. A newly registered account exists only until the app restarts.',
            ),
          ),
        ],
      ),
    ),
  );
}
