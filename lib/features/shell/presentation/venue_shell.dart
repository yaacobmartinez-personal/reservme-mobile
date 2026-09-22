import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ui/app_bottom_nav.dart';

/// Bottom navigation for venue staff: Today · Calendar · Customers · More.
class VenueShell extends StatelessWidget {
  const VenueShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const items = [
    NavItem(icon: Icons.schedule_outlined, selectedIcon: Icons.schedule_rounded, label: 'Today'),
    NavItem(
      icon: Icons.calendar_month_outlined,
      selectedIcon: Icons.calendar_month_rounded,
      label: 'Calendar',
    ),
    NavItem(icon: Icons.people_outline_rounded, selectedIcon: Icons.people_rounded, label: 'Customers'),
    NavItem(icon: Icons.menu_rounded, selectedIcon: Icons.menu_rounded, label: 'More'),
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
