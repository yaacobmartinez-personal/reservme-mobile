import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/customer/account/presentation/account_screen.dart';
import '../../features/shell/application/app_mode_controller.dart';
import '../../features/shell/presentation/animated_branches.dart';
import '../../features/shell/presentation/customer_shell.dart';
import '../../features/shell/presentation/placeholder_screen.dart';
import '../../features/shell/presentation/venue_shell.dart';
import '../../features/venue/more/presentation/more_screen.dart';
import '../../features/venue/venues/application/selected_venue_controller.dart';
import '../../features/venue/venues/presentation/venue_picker_screen.dart';
import 'guards.dart';
import 'router_refresh.dart';
import 'routes.dart';
import 'transitions.dart';

part 'app_router.g.dart';

/// Two independent bottom-nav shells (customer `/c`, venue `/v`), the auth
/// stack and the onboarding flow. Each shell keeps its own tab state via
/// `indexedStack`. Redirect rules live in [computeRedirect].
///
/// Routes that must cover the bottom nav (the QR scanner, onboarding) push
/// on the root navigator via [rootNavigatorKey].
final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = RouterRefresh(ref);
  ref.onDispose(refresh.dispose);

  final auth = ref.read(authControllerProvider);
  final mode = ref.read(appModeControllerProvider);
  final initial = auth.hasVenueAccess && mode == AppMode.venue ? mode.home : AppMode.customer.home;

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initial,
    refreshListenable: refresh,
    debugLogDiagnostics: false,
    redirect: (context, state) => computeRedirect(
      uri: state.uri,
      auth: ref.read(authControllerProvider),
      mode: ref.read(appModeControllerProvider),
      selectedVenueSlug: ref.read(selectedVenueSlugProvider),
    ),
    routes: [
      // ---- auth stack -------------------------------------------------------
      GoRoute(
        path: Routes.login,
        pageBuilder: (context, state) => sharedAxisPage(
          state: state,
          child: const PlaceholderScreen(title: 'Sign in', board: 'V1 · Staff sign in', showBack: true),
        ),
      ),
      GoRoute(
        path: Routes.forgot,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Reset password',
          board: 'V2 · Forgot password',
          showBack: true,
        ),
      ),

      // ---- onboarding -------------------------------------------------------
      GoRoute(
        path: Routes.welcome,
        pageBuilder: (context, state) => fadeThroughPage(
          state: state,
          child: const PlaceholderScreen(title: 'Welcome', board: 'O0 · Welcome', showBack: true),
        ),
        routes: [
          for (final (segment, title, board) in const [
            ('signup', 'Create your owner account', 'O1 · Sign up'),
            ('verify', 'Check your email', 'O2 · Verify email'),
            ('venue', 'Name your venue', 'O3 · Create venue'),
            ('space', 'Add your first space', 'O4 · First space'),
            ('hours', 'Opening hours', 'O5 · Opening hours'),
            ('policy', 'Booking rules', 'O6 · Booking policy'),
            ('live', "You're live", 'O7 · Live'),
          ])
            GoRoute(
              path: segment,
              pageBuilder: (context, state) => sharedAxisPage(
                state: state,
                child: PlaceholderScreen(title: title, board: board, showBack: true),
              ),
            ),
        ],
      ),

      // ---- customer shell ---------------------------------------------------
      StatefulShellRoute(
        builder: (context, state, navigationShell) =>
            CustomerShell(navigationShell: navigationShell),
        navigatorContainerBuilder: (context, shell, children) =>
            AnimatedBranches(shell: shell, children: children),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.customerFind,
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Find a venue', board: 'C1 · Find'),
                routes: [
                  GoRoute(
                    path: 'scan',
                    parentNavigatorKey: rootNavigatorKey,
                    pageBuilder: (context, state) => slideUpPage(
                      state: state,
                      child: const PlaceholderScreen(
                        title: 'Scan a venue QR',
                        board: 'C2 · Scan',
                        showBack: true,
                      ),
                    ),
                  ),
                  GoRoute(
                    path: 'venues/:slug',
                    builder: (context, state) => PlaceholderScreen(
                      title: state.pathParameters['slug']!,
                      board: 'C3 · Venue page',
                      showBack: true,
                    ),
                    routes: [
                      GoRoute(
                        path: 'spaces/:space',
                        builder: (context, state) => PlaceholderScreen(
                          title: 'Pick a slot',
                          board: 'C4 · Pick a slot',
                          subtitle: 'date=${state.uri.queryParameters['date'] ?? 'today'}',
                          showBack: true,
                        ),
                      ),
                      GoRoute(
                        path: 'book',
                        builder: (context, state) => const PlaceholderScreen(
                          title: 'Your booking',
                          board: 'C6 · Your details',
                          showBack: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.customerBookings,
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Bookings', board: 'C9 · My bookings'),
                routes: [
                  // Literal before the parameters so "import" is never a slug.
                  GoRoute(
                    path: 'import',
                    builder: (context, state) => const PlaceholderScreen(
                      title: 'Booking',
                      board: 'C11 · Import / invalid link',
                      showBack: true,
                    ),
                  ),
                  GoRoute(
                    path: ':slug/:token',
                    builder: (context, state) => const PlaceholderScreen(
                      title: 'Booking',
                      board: 'C8 · Booked',
                      showBack: true,
                    ),
                    routes: [
                      GoRoute(
                        path: 'reschedule',
                        builder: (context, state) => const PlaceholderScreen(
                          title: 'Reschedule',
                          board: 'C10 · Reschedule',
                          showBack: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.customerAccount,
                builder: (context, state) => const AccountScreen(),
              ),
            ],
          ),
        ],
      ),

      // ---- venue: picker outside the shell ---------------------------------
      GoRoute(
        path: Routes.venuePicker,
        pageBuilder: (context, state) =>
            fadeThroughPage(state: state, child: const VenuePickerScreen()),
      ),

      // ---- venue shell ------------------------------------------------------
      StatefulShellRoute(
        builder: (context, state, navigationShell) =>
            VenueShell(navigationShell: navigationShell),
        navigatorContainerBuilder: (context, shell, children) =>
            AnimatedBranches(shell: shell, children: children),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.venueToday,
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Today', board: 'V4 · Today'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.venueCalendar,
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Calendar', board: 'V7 · Calendar'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.venueCustomers,
                builder: (context, state) =>
                    const PlaceholderScreen(title: 'Customers', board: 'V10 · Customers'),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => const PlaceholderScreen(
                      title: 'Customer',
                      board: 'V11 · Customer detail',
                      showBack: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.venueMore,
                builder: (context, state) => const MoreScreen(),
                routes: [
                  for (final (segment, title, board) in const [
                    ('waitlist', 'Waitlist', 'V13 · Waitlist'),
                    ('settings', 'Venue settings', 'G2 · Venue settings'),
                    ('team', 'Team', 'G3 · Team'),
                    ('billing', 'Billing', 'G4 · Billing'),
                    ('insights', 'Insights', 'G5 · Insights'),
                    ('account', 'Your account', 'G7 · Owner account'),
                  ])
                    GoRoute(
                      path: segment,
                      builder: (context, state) =>
                          PlaceholderScreen(title: title, board: board, showBack: true),
                    ),
                  GoRoute(
                    path: 'spaces',
                    builder: (context, state) => const PlaceholderScreen(
                      title: 'Spaces',
                      board: 'V14 · Spaces',
                      showBack: true,
                    ),
                    routes: [
                      GoRoute(
                        path: ':id',
                        builder: (context, state) => const PlaceholderScreen(
                          title: 'Space',
                          board: 'G1 · Space editor',
                          showBack: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
