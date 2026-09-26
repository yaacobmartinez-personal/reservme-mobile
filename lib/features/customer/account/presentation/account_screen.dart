import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/api_mode.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/storage/local_store.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../../core/ui/primitives.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../auth/application/auth_controller.dart';
import '../../../settings/application/appearance_controller.dart';
import '../../../shell/application/app_mode_controller.dart';
import '../../booking/application/book_controller.dart';

/// C12 · Account — for a customer who has no account. What lives here is what
/// lives on the phone: the contact details used to prefill a booking, the
/// appearance choice, the way into venue mode, and a way to erase all of it.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final auth = ref.watch(authControllerProvider);
    final appearance = ref.watch(appearanceControllerProvider);
    final apiMode = ref.watch(apiModeProvider);
    final contact = ref.watch(savedContactProvider).value;

    Widget group(List<Widget> tiles) => AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (final (i, t) in tiles.indexed) ...[if (i > 0) const Divider(), t],
            ],
          ),
        );

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: Spacing.x6),
          children: [
            const BigHeader(eyebrow: 'No account needed', title: 'You'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.gutter),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Eyebrow('Your details'),
                  const SizedBox(height: Spacing.x2),
                  AppCard(
                    onTap: () => _editContact(context, ref, contact ?? const Contact()),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: p.pineSoft,
                            borderRadius: BorderRadius.circular(Radii.sm),
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.person_outline_rounded, color: p.pineInk),
                        ),
                        const SizedBox(width: Spacing.x3),
                        Expanded(
                          child: contact == null || contact.isEmpty
                              ? Text(
                                  'Add your name and email',
                                  style: AppType.bodyStrong.copyWith(color: p.ink),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contact.name.isEmpty ? 'No name yet' : contact.name,
                                      style: AppType.bodyStrong.copyWith(color: p.ink, fontSize: 16),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      [contact.email, contact.phone]
                                          .where((s) => s.isNotEmpty)
                                          .join(' · '),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppType.caption.copyWith(color: p.ink3),
                                    ),
                                  ],
                                ),
                        ),
                        Icon(Icons.edit_outlined, size: 18, color: p.ink3),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.x2),
                  Text(
                    'Saved on this phone to prefill bookings. Never sent anywhere '
                    'until you book.',
                    style: AppType.caption.copyWith(color: p.ink3),
                  ),
                  const SizedBox(height: Spacing.x5),
                  const Eyebrow('Preferences'),
                  const SizedBox(height: Spacing.x2),
                  group([
                    // Label above, control below: side by side, the segmented
                    // control took the row and broke "Appearance" mid-word on a
                    // 360pt phone.
                    ListTile(
                      leading: const Icon(Icons.dark_mode_outlined),
                      title: const Text('Appearance'),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: Spacing.x2),
                        child: SizedBox(
                          width: double.infinity,
                          child: SegmentedButton<ThemeMode>(
                            showSelectedIcon: false,
                            style: SegmentedButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              textStyle: AppType.buttonS,
                            ),
                            segments: const [
                              ButtonSegment(value: ThemeMode.system, label: Text('Auto')),
                              ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                              ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
                            ],
                            selected: {appearance},
                            onSelectionChanged: (s) =>
                                ref.read(appearanceControllerProvider.notifier).set(s.first),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: Spacing.x5),
                  const Eyebrow('Venue staff'),
                  const SizedBox(height: Spacing.x2),
                  group([
                    if (auth.hasVenueAccess)
                      ListTile(
                        leading: Icon(Icons.swap_horiz_rounded, color: p.pineInk),
                        title: const Text('Switch to venue mode'),
                        subtitle: Text('Signed in as ${auth.userOrNull?.email ?? ''}'),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () {
                          ref.read(appModeControllerProvider.notifier).set(AppMode.venue);
                          context.go(AppMode.venue.home);
                        },
                      )
                    else
                      ListTile(
                        leading: Icon(Icons.login_rounded, color: p.pineInk),
                        title: const Text('Sign in to venue mode'),
                        subtitle: const Text('Run sheet, calendar, customers'),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => context.push(Routes.login),
                      ),
                  ]),
                  const SizedBox(height: Spacing.x5),
                  const Eyebrow('Data'),
                  const SizedBox(height: Spacing.x2),
                  group([
                    ListTile(
                      leading: Icon(Icons.delete_outline_rounded, color: p.danger),
                      title: Text(
                        'Delete everything on this phone',
                        style: AppType.bodyStrong.copyWith(color: p.danger),
                      ),
                      subtitle: const Text('Bookings, contact details, recent venues'),
                      onTap: () => _wipe(context, ref),
                    ),
                  ]),
                  const SizedBox(height: Spacing.x8),
                  Center(
                    child: Text(
                      versionLine(apiMode),
                      style: AppType.caption.copyWith(color: p.ink3),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editContact(BuildContext context, WidgetRef ref, Contact current) async {
    final result = await showModalBottomSheet<Contact>(
      context: context,
      // On the root navigator, or the shell's bottom nav sits on top of it.
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => _ContactSheet(contact: current),
    );
    if (result != null) await ref.read(savedContactProvider.notifier).save(result);
  }

  Future<void> _wipe(BuildContext context, WidgetRef ref) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete everything on this phone?',
      message: 'Your saved bookings, contact details and recent venues are removed '
          'from this device. The bookings themselves stay — the venue still has '
          'them, and the links in your emails still open them.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (!confirmed) return;
    await ref.read(localStoreProvider).wipe();
    await ref.read(savedContactProvider.notifier).clear();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Everything on this phone has been deleted.')),
      );
    }
  }
}

class _ContactSheet extends StatefulWidget {
  const _ContactSheet({required this.contact});

  final Contact contact;

  @override
  State<_ContactSheet> createState() => _ContactSheetState();
}

class _ContactSheetState extends State<_ContactSheet> {
  late final _name = TextEditingController(text: widget.contact.name);
  late final _email = TextEditingController(text: widget.contact.email);
  late final _phone = TextEditingController(text: widget.contact.phone);

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Spacing.gutter,
            0,
            Spacing.gutter,
            Spacing.gutter,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your details',
                style: AppType.displayAt(22).copyWith(color: p.ink),
              ),
              const SizedBox(height: Spacing.x4),
              TextField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: Spacing.x3),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: Spacing.x3),
              TextField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Mobile — optional'),
              ),
              const SizedBox(height: Spacing.x5),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(
                  Contact(
                    name: _name.text.trim(),
                    email: _email.text.trim(),
                    phone: _phone.text.trim(),
                  ),
                ),
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
                child: const Text('Save on this phone'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
