import '../../../core/providers/demo_mode.dart';
import '../../../core/widgets/ui.dart';
import '../../auth/presentation/auth_controller.dart';
import 'preferences_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final preferences = ref.watch(preferencesProvider);
    final mode = ref.watch(demoModeProvider);
    return PageBody(
      title: 'Make yourself at home.',
      subtitle: 'Your preferences and demo controls.',
      children: [
        Panel(
          child: Row(
            children: [
              const CircleAvatar(radius: 26, child: Icon(Icons.person_outline)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.displayName ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(user?.email ?? ''),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle('Preferences'),
        Panel(
          child: Column(
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Repayment reminders'),
                subtitle: const Text(
                  'Demo preference only. Device notifications are not scheduled yet.',
                ),
                value: preferences.reminders,
                onChanged: (v) =>
                    ref.read(preferencesProvider.notifier).update(reminders: v),
              ),
              const Divider(),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Example explanations'),
                subtitle: const Text(
                  'Allow the local explanation preview for fictional terms.',
                ),
                value: preferences.aiConsent,
                onChanged: (v) =>
                    ref.read(preferencesProvider.notifier).update(aiConsent: v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle('Classroom demo'),
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Preview each data state without changing the sample records. Offline mode keeps records readable and blocks loan changes.',
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<DemoMode>(
                key: ValueKey(mode),
                initialValue: mode,
                decoration: const InputDecoration(labelText: 'Demo data state'),
                items: [
                  for (final option in DemoMode.values)
                    DropdownMenuItem(value: option, child: Text(option.name)),
                ],
                onChanged: (v) {
                  if (v != null) ref.read(demoModeProvider.notifier).setMode(v);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'To demonstrate both sides of an agreement, sign out and choose the other demo account. Abel and Sara share the sample loan; Sara owns the first two offers.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const SectionTitle('Privacy'),
        const Panel(
          child: Text(
            'All accounts, offers and repayments in this milestone are held in memory. No money moves, no network service is used, and no receipt photo is saved. Restarting the app resets all changes. Signing out hides your records; demo records remain in memory so the other participant can confirm them.',
          ),
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: () {
            ref.read(demoModeProvider.notifier).setMode(DemoMode.normal);
            ref.read(authProvider.notifier).signOut();
          },
          icon: const Icon(Icons.logout),
          label: const Text('Sign out'),
        ),
      ],
    );
  }
}
