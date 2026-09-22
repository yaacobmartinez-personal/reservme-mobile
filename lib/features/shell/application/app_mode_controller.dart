import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/boot_data.dart';
import '../../../core/storage/prefs.dart';

part 'app_mode_controller.g.dart';

/// Which side of the app the person is using. Customer is the default and
/// needs no account; the venue shell is offered once the signed-in user has a
/// venue membership.
enum AppMode {
  customer('/c/find'),
  venue('/v/today');

  const AppMode(this.home);

  /// The route each shell opens on.
  final String home;

  static AppMode parse(String? raw) => raw == 'venue' ? AppMode.venue : AppMode.customer;
}

@Riverpod(keepAlive: true)
class AppModeController extends _$AppModeController {
  @override
  AppMode build() => AppMode.parse(ref.watch(bootDataProvider).appMode);

  void set(AppMode mode) {
    if (state == mode) return;
    state = mode;
    // Fire and forget: a lost write just means the next launch opens the
    // other shell.
    ref.read(prefsProvider).setString(Prefs.keyAppMode, mode.name);
  }
}
