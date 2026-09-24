import 'package:flutter/material.dart';

import '../../../../../core/theme/palette.dart';
import '../../../../../core/theme/typography.dart';
import '../../domain/customer.dart';

/// Initials on a tinted square. The tint is derived from the name, so the
/// same person is the same colour everywhere without storing anything.
class CustomerAvatar extends StatelessWidget {
  const CustomerAvatar({super.key, required this.customer, this.size = 48});

  final CustomerSummary customer;
  final double size;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    // Someone with a no-show reads clay; everyone else pine.
    final warm = customer.noShowCount > 0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: warm ? p.claySoft : p.pineSoft,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        customer.initials,
        style: AppType.bodyStrong.copyWith(
          color: warm ? p.clayInk : p.pineInk,
          fontSize: size * 0.34,
        ),
      ),
    );
  }
}
