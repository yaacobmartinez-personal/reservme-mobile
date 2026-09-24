import '../../../../core/fake/fake_latency.dart';
import '../../../../core/fake/fake_store.dart';
import '../../../../core/model/enums.dart';
import '../../../../core/network/api_error.dart';
import '../../../../core/time/app_time.dart';
import '../../../../core/time/clock.dart';
import '../domain/venue_settings.dart';

/// In-memory [SettingsRepository], porting `updateVenueSettings` from
/// `src/app/app/actions.ts` and the branding writes from
/// `branding-actions.ts`.
class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository(
    this._store,
    this._latency,
    this._clock,
    this._offline,
    this._roleFor,
  );

  final FakeStore _store;
  final FakeLatency _latency;
  final Clock _clock;
  final bool Function() _offline;
  final VenueRole? Function(String venueSlug) _roleFor;

  Future<void> _tick() async {
    if (_offline()) throw ApiError.network();
    await _latency.wait();
  }

  FakeVenue _venue(String slug) {
    final v = _store.venueBySlug(slug);
    if (v == null) throw ApiError(404, 'We could not find that venue.');
    return v;
  }

  FakeVenue _manageable(String slug) {
    final venue = _venue(slug);
    final role = _roleFor(slug);
    if (role == null || !role.atLeast(VenueRole.admin)) {
      throw ApiError(403, 'Only an owner or admin can change venue settings.');
    }
    return venue;
  }

  @override
  Future<VenueSettings> get(String venueSlug) async {
    await _tick();
    return _view(_venue(venueSlug));
  }

  @override
  Future<VenueSettings> update(
    String venueSlug,
    VenueSettingsInput input,
  ) async {
    await _tick();
    final venue = _manageable(venueSlug);
    final refusal = input.validate();
    if (refusal != null) throw ApiError(400, refusal);

    // A timezone the device cannot resolve would make every rendered time
    // wrong rather than obviously broken, so it is refused here.
    if (!AppTime.isValidTimeZone(input.timezone)) {
      throw ApiError(400, 'We do not know that timezone.');
    }

    String? orNull(String v) => v.trim().isEmpty ? null : v.trim();

    venue
      ..name = input.name.trim()
      ..tagline = orNull(input.tagline)
      ..address = orNull(input.address)
      ..timezone = input.timezone
      ..currency = input.currency.toUpperCase()
      ..theme = input.theme
      ..minNoticeMinutes = input.minNoticeMinutes
      ..maxHorizonDays = input.maxHorizonDays
      ..cancellationMode = input.cancellationMode
      ..cancellationGraceHours = input.cancellationGraceHours
      ..refundTerms = orNull(input.refundTerms)
      ..gcashName = orNull(input.gcashName);

    return _view(venue);
  }

  @override
  Future<VenueSettings> setBranding(
    String venueSlug,
    BrandingSlot slot,
    List<int>? image,
  ) async {
    await _tick();
    final venue = _manageable(venueSlug);
    if (image != null && image.length > _maxImageBytes) {
      throw ApiError(413, 'That image is too large — keep it under 2 MB.');
    }

    final url = image == null
        ? null
        : 'fake://venues/${venue.id}/${slot.wire}/'
            '${_clock().millisecondsSinceEpoch}.jpg';
    switch (slot) {
      case BrandingSlot.logo:
        venue.logoUrl = url;
      case BrandingSlot.cover:
        venue.coverUrl = url;
    }
    return _view(venue);
  }

  static const _maxImageBytes = 2 * 1024 * 1024;

  VenueSettings _view(FakeVenue v) => VenueSettings(
        slug: v.slug,
        name: v.name,
        tagline: v.tagline,
        address: v.address,
        timezone: v.timezone,
        currency: v.currency,
        theme: v.theme,
        logoUrl: v.logoUrl,
        coverUrl: v.coverUrl,
        minNoticeMinutes: v.minNoticeMinutes,
        maxHorizonDays: v.maxHorizonDays,
        cancellationMode: v.cancellationMode,
        cancellationGraceHours: v.cancellationGraceHours,
        refundTerms: v.refundTerms,
        gcashName: v.gcashName,
        suspended: v.suspended,
        suspendedReason: v.suspendedReason,
      );
}
