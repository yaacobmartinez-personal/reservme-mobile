import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../venue_providers.dart';
import '../domain/waitlist_entry.dart';

part 'venue_waitlist_controller.g.dart';

/// V13 · Waitlist — read-only in v1. The auto-fill that offers a freed slot
/// runs on the server; the venue watches the queue.
@riverpod
Future<List<WaitlistEntry>> venueWaitlist(Ref ref, String venueSlug) =>
    ref.watch(venueWaitlistRepositoryProvider).entries(venueSlug);
