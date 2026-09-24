import '../../../../core/config/app_config.dart';
import '../../../../core/config/feature_availability.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_error.dart';
import '../domain/customer.dart';
import '../domain/customers_repository.dart';

/// [CustomersRepository] over the HTTP API (API-CONTRACT #20–#22).
class RealCustomersRepository implements CustomersRepository {
  RealCustomersRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  void _guard() {
    if (!isAvailable(Feature.customers, _mode)) throw ApiError.notAvailable();
  }

  @override
  Future<CustomerPage> list(
    String venueSlug, {
    String? search,
    CustomerSegment segment = CustomerSegment.all,
  }) async {
    _guard();
    return CustomerPage.fromJson(
      await _api.get('/mobile/venues/$venueSlug/customers', query: {
        if ((search ?? '').isNotEmpty) 'q': search,
        if (segment != CustomerSegment.all) 'segment': segment.name,
      }),
    );
  }

  @override
  Future<CustomerProfile> detail(String venueSlug, String customerId) async {
    _guard();
    return CustomerProfile.fromJson(
      await _api.get('/mobile/venues/$venueSlug/customers/$customerId'),
    );
  }

  @override
  Future<CustomerNote> addNote(
    String venueSlug,
    String customerId,
    String body,
  ) async {
    _guard();
    final json = await _api.post(
      '/mobile/venues/$venueSlug/customers/$customerId/notes',
      body: {'body': body.trim()},
    );
    return CustomerNote.fromJson(json['note'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteNote(
    String venueSlug,
    String customerId,
    String noteId,
  ) async {
    _guard();
    await _api.delete('/mobile/venues/$venueSlug/customers/$customerId/notes/$noteId');
  }

  @override
  Future<CustomerSummary> setTags(
    String venueSlug,
    String customerId,
    List<String> tags,
  ) async {
    _guard();
    final json = await _api.put(
      '/mobile/venues/$venueSlug/customers/$customerId/tags',
      body: {'tags': tags},
    );
    return CustomerSummary.fromJson(json['customer'] as Map<String, dynamic>);
  }

  @override
  Future<CustomerSummary> updateContact(
    String venueSlug,
    String customerId, {
    required String name,
    String? phone,
  }) async {
    _guard();
    final json = await _api.patch(
      '/mobile/venues/$venueSlug/customers/$customerId',
      body: {'name': name.trim(), 'phone': (phone ?? '').trim()},
    );
    return CustomerSummary.fromJson(json['customer'] as Map<String, dynamic>);
  }
}
