import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/palette.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../../auth/application/auth_controller.dart';
import '../application/selected_venue_controller.dart';

/// The pill in venue-shell headers showing the selected venue; opens the
/// picker when the user belongs to more than one.
class VenueSwitcherButton extends ConsumerWidget {
  const VenueSwitcherButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = context.palette;
    final venue = ref.watch(selectedVenueProvider);
    final count = ref.watch(authControllerProvider).venuesOrEmpty.length;
    final canSwitch = count > 1;
    return Material(
      color: p.card,
      shape: StadiumBorder(side: BorderSide(color: p.rule)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: canSwitch ? () => context.push(Routes.venuePicker) : null,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.x3, Spacing.x2, Spacing.x2, Spacing.x2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 150),
                child: Text(
                  venue?.name ?? 'Choose venue',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppType.buttonS.copyWith(color: p.ink),
                ),
              ),
              if (canSwitch) Icon(Icons.expand_more_rounded, size: 18, color: p.ink3),
            ],
          ),
        ),
      ),
    );
  }
}
