import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/app_bottom_nav.dart';

/// Bottom navigation for the customer side: Find · Bookings · Account.
/// Fully public — no sign-in anywhere on this side.
class CustomerShell extends StatelessWidget {
  const CustomerShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const items = [
    NavItem(icon: Icons.search_rounded, selectedIcon: Icons.search_rounded, label: 'Find'),
    NavItem(
      icon: Icons.calendar_today_outlined,
      selectedIcon: Icons.calendar_today_rounded,
      label: 'Bookings',
    ),
    NavItem(icon: Icons.person_outline_rounded, selectedIcon: Icons.person_rounded, label: 'Account'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNav(
        items: items,
        selectedIndex: navigationShell.currentIndex,
        onSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
