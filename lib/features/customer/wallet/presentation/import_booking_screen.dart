import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_error.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/empty_state.dart';
import '../application/wallet_controller.dart';

/// C11 · Opening a manage link. The link from a confirmation email lands
/// here: fetch the booking, save it to the wallet, and replace this screen
/// with the booking itself. A bad token gets the "no longer valid" state.
class ImportBookingScreen extends ConsumerStatefulWidget {
  const ImportBookingScreen({super.key, required this.slug, required this.token});

  final String? slug;
  final String? token;

  @override
  ConsumerState<ImportBookingScreen> createState() => _ImportBookingScreenState();
}

class _ImportBookingScreenState extends ConsumerState<ImportBookingScreen> {
  Object? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _run());
  }

  Future<void> _run() async {
    final slug = widget.slug;
    final token = widget.token;
    if (slug == null || slug.isEmpty || token == null || token.isEmpty) {
      setState(() => _error = ApiError(404, 'This link is no longer valid.'));
      return;
    }
    try {
      await ref
          .read(importBookingProvider.notifier)
          .import(venueSlug: slug, token: token);
      if (mounted) {
        context.pushReplacement(Routes.booking(slug, token));
      }
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final notFound = _error is ApiError && (_error as ApiError).isNotFound;
    return Scaffold(
      appBar: AppBar(title: const Text('Booking')),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.gutter),
        child: EmptyState(
          icon: notFound ? Icons.link_off_rounded : Icons.wifi_off_rounded,
          title: notFound ? 'This link is no longer valid' : "We couldn't open that link",
          hint: notFound
              ? 'The booking may have been cancelled, or the venue rotated the link. '
                  'Check your latest email from the venue, or contact them with your '
                  'reference.'
              : 'Check your connection and try again.',
          action: FilledButton(
            onPressed: notFound
                ? () => context.go(Routes.customerBookings)
                : () {
                    setState(() => _error = null);
                    _run();
                  },
            child: Text(notFound ? 'Back to my bookings' : 'Try again'),
          ),
        ),
      ),
    );
  }
}
