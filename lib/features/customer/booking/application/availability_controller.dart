import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../../customer_providers.dart';
import '../domain/availability.dart';

part 'availability_controller.g.dart';

/// Which venue-local date the slot picker is showing. Defaults to today in
/// the venue's zone — not the phone's.
@riverpod
class SelectedDate extends _$SelectedDate {
  @override
  String build(String venueSlug, String timezone) =>
      AppTime.today(ref.read(clockProvider)(), timezone);

  void set(String date) => state = date;
}

/// Slots and sessions for one space on one date.
@riverpod
Future<DayAvailability> availability(
  Ref ref, {
  required String venueSlug,
  required String spaceId,
  required String date,
}) =>
    ref.watch(bookingRepositoryProvider).availability(
          venueSlug: venueSlug,
          spaceId: spaceId,
          date: date,
        );

/// The dates the strip offers: today through the venue's booking horizon,
/// capped so the strip stays a strip.
@riverpod
List<String> bookableDates(
  Ref ref, {
  required String timezone,
  required int horizonDays,
  int limit = 14,
}) {
  final today = AppTime.today(ref.watch(clockProvider)(), timezone);
  final count = horizonDays < limit ? horizonDays + 1 : limit;
  return [for (var i = 0; i < count; i++) AppTime.addDays(today, i, timezone)];
}
