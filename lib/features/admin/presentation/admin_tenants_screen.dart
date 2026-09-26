import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/widgets/async_view.dart';
import '../../../core/widgets/empty_state.dart';
import '../application/admin_controllers.dart';
import 'widgets/admin_widgets.dart';

/// Every venue on the platform (API-CONTRACT #36), suspended ones last and
/// newest first, searchable by name or booking-page address.
class AdminTenantsScreen extends ConsumerStatefulWidget {
  const AdminTenantsScreen({super.key});

  @override
  ConsumerState<AdminTenantsScreen> createState() => _AdminTenantsScreenState();
}

class _AdminTenantsScreenState extends ConsumerState<AdminTenantsScreen> {
  final _search = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _query = value.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = adminTenantsProvider(_query);
    final tenants = ref.watch(provider);
    return Scaffold(
      appBar: AppBar(title: const Text('Venues')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Spacing.gutter, 0, Spacing.gutter, Spacing.x3),
            child: TextField(
              controller: _search,
              onChanged: _onChanged,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Name or booking address',
              ),
            ),
          ),
          Expanded(
            child: AsyncView(
              value: tenants,
              onRetry: () => ref.invalidate(provider),
              data: (list) => list.isEmpty
                  ? EmptyState(
                      icon: Icons.storefront_outlined,
                      title: _query.isEmpty ? 'No venues yet' : 'No venue matches that',
                      hint: _query.isEmpty
                          ? 'Venues appear here as owners sign up.'
                          : 'Try part of the name, or the address after reservme.pro/.',
                    )
                  : RefreshIndicator(
                      onRefresh: () async => ref.refresh(provider.future),
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(
                          Spacing.gutter,
                          0,
                          Spacing.gutter,
                          Spacing.x8,
                        ),
                        children: [
                          AdminGroup(children: [
                            for (final t in list)
                              TenantTile(
                                tenant: t,
                                onTap: () => context.push(Routes.adminTenant(t.orgId)),
                              ),
                          ]),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
