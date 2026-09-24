import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../venue_providers.dart';
import '../domain/insights.dart';

part 'insights_controller.g.dart';

/// G5 · Insights. Keyed by range, so switching period keeps the previous
/// window's answer on screen while the new one loads.
@riverpod
Future<Insights> insights(Ref ref, String venueSlug, InsightsRange range) =>
    ref.watch(insightsRepositoryProvider).get(venueSlug, range);

/// The period the owner last looked at, so the screen reopens on it.
@riverpod
class InsightsRangeController extends _$InsightsRangeController {
  @override
  InsightsRange build() => InsightsRange.month;

  void set(InsightsRange range) => state = range;
}
