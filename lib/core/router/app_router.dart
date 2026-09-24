import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/customer/account/presentation/account_screen.dart';
import '../../features/customer/booking/presentation/booking_form_screen.dart';
import '../../features/customer/booking/presentation/space_day_screen.dart';
import '../../features/customer/venues/presentation/find_venue_screen.dart';
import '../../features/customer/venues/presentation/scan_screen.dart';
import '../../features/customer/venues/presentation/venue_screen.dart';
import '../../features/customer/wallet/presentation/booking_detail_screen.dart';
import '../../features/customer/wallet/presentation/bookings_screen.dart';
import '../../features/customer/wallet/presentation/import_booking_screen.dart';
import '../../features/customer/wallet/presentation/reschedule_screen.dart';
import '../../features/onboarding/presentation/create_venue_screen.dart';
import '../../features/onboarding/presentation/first_space_screen.dart';
import '../../features/onboarding/presentation/hours_screen.dart';
import '../../features/onboarding/presentation/live_screen.dart';
import '../../features/onboarding/presentation/policy_screen.dart';
import '../../features/onboarding/presentation/signup_screen.dart';
import '../../features/onboarding/presentation/verify_screen.dart';
import '../../features/onboarding/presentation/welcome_screen.dart';
import '../../features/shell/application/app_mode_controller.dart';
import '../../features/shell/presentation/animated_branches.dart';
import '../../features/shell/presentation/customer_shell.dart';
import '../../features/shell/presentation/placeholder_screen.dart';
import '../../features/shell/presentation/venue_shell.dart';
import '../../features/venue/calendar/presentation/calendar_screen.dart';
import '../../features/venue/customers/presentation/customer_detail_screen.dart';
import '../../features/venue/customers/presentation/customers_screen.dart';
import '../../features/venue/more/presentation/more_screen.dart';
import '../../features/venue/settings/presentation/venue_settings_screen.dart';
import '../../features/venue/spaces/presentation/space_editor_screen.dart';
import '../../features/venue/spaces/presentation/spaces_screen.dart';
import '../../features/venue/today/presentation/today_screen.dart';
import '../../features/venue/venues/application/selected_venue_controller.dart';
import '../../features/venue/venues/presentation/venue_picker_screen.dart';
import '../../features/venue/waitlist/presentation/waitlist_screen.dart';
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
          child: LoginScreen(from: state.uri.queryParameters['from']),
        ),
      ),
      GoRoute(
        path: Routes.forgot,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // ---- onboarding -------------------------------------------------------
      GoRoute(
        path: Routes.welcome,
        pageBuilder: (context, state) =>
            fadeThroughPage(state: state, child: const WelcomeScreen()),
        routes: [
          for (final (segment, screen) in <(String, Widget)>[
            ('signup', const SignupScreen()),
            ('verify', const VerifyScreen()),
            ('venue', const CreateVenueScreen()),
            ('space', const FirstSpaceScreen()),
            ('hours', const HoursScreen()),
            ('policy', const PolicyScreen()),
            ('live', const LiveScreen()),
          ])
            GoRoute(
              path: segment,
              pageBuilder: (context, state) =>
                  sharedAxisPage(state: state, child: screen),
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
                builder: (context, state) => const FindVenueScreen(),
                routes: [
                  GoRoute(
                    path: 'scan',
                    parentNavigatorKey: rootNavigatorKey,
                    pageBuilder: (context, state) =>
                        slideUpPage(state: state, child: const ScanScreen()),
                  ),
                  GoRoute(
                    path: 'venues/:slug',
                    builder: (context, state) =>
                        VenueScreen(slug: state.pathParameters['slug']!),
                    routes: [
                      GoRoute(
                        path: 'spaces/:space',
                        builder: (context, state) => SpaceDayScreen(
                          slug: state.pathParameters['slug']!,
                          spaceId: state.pathParameters['space']!,
                          initialDate: state.uri.queryParameters['date'],
                        ),
                      ),
                      GoRoute(
                        path: 'book',
                        builder: (context, state) => BookingFormScreen(
                          slug: state.pathParameters['slug']!,
                          draft: state.extra is BookingDraft
                              ? state.extra! as BookingDraft
                              : null,
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
                builder: (context, state) => const BookingsScreen(),
                routes: [
                  // Literal before the parameters so "import" is never a slug.
                  GoRoute(
                    path: 'import',
                    builder: (context, state) => ImportBookingScreen(
                      slug: state.uri.queryParameters['slug'],
                      token: state.uri.queryParameters['token'],
                    ),
                  ),
                  GoRoute(
                    path: ':slug/:token',
                    builder: (context, state) => BookingDetailScreen(
                      slug: state.pathParameters['slug']!,
                      token: state.pathParameters['token']!,
                      arrival: state.extra is BookingArrival
                          ? state.extra! as BookingArrival
                          : null,
                    ),
                    routes: [
                      GoRoute(
                        path: 'reschedule',
                        builder: (context, state) => RescheduleScreen(
                          slug: state.pathParameters['slug']!,
                          token: state.pathParameters['token']!,
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
                builder: (context, state) => const TodayScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.venueCalendar,
                builder: (context, state) => CalendarScreen(
                  initialDate: state.uri.queryParameters['date'],
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.venueCustomers,
                builder: (context, state) => const CustomersScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => CustomerDetailScreen(
                      customerId: state.pathParameters['id']!,
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
                  GoRoute(
                    path: 'waitlist',
                    builder: (context, state) => const WaitlistScreen(),
                  ),
                  GoRoute(
                    path: 'settings',
                    builder: (context, state) => const VenueSettingsScreen(),
                  ),
                  for (final (segment, title, board) in const [
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
                    builder: (context, state) => const SpacesScreen(),
                    routes: [
                      GoRoute(
                        path: ':id',
                        builder: (context, state) => SpaceEditorScreen(
                          spaceId: state.pathParameters['id']!,
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
