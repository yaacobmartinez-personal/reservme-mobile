import 'dart:convert';

import '../../../core/config/app_config.dart';
import '../../../core/config/feature_availability.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_error.dart';
import '../domain/admin.dart';

/// [AdminRepository] over the HTTP API (API-CONTRACT #35–#41).
class RealAdminRepository implements AdminRepository {
  RealAdminRepository(this._api, this._mode);

  final ApiClient _api;
  final ApiMode _mode;

  void _guard() {
    if (!isAvailable(Feature.admin, _mode)) throw ApiError.notAvailable();
  }

  static List<Map<String, dynamic>> _list(Object? raw) =>
      (raw as List<dynamic>? ?? const []).whereType<Map<String, dynamic>>().toList();

  @override
  Future<AdminOverview> overview() async {
    _guard();
    return AdminOverview.fromJson(await _api.get('/mobile/admin/overview'));
  }

  @override
  Future<List<TenantSummary>> tenants({String? query}) async {
    _guard();
    final q = query?.trim();
    final json = await _api.get(
      '/mobile/admin/tenants',
      query: q == null || q.isEmpty ? null : {'q': q},
    );
    return [for (final t in _list(json['tenants'])) TenantSummary.fromJson(t)];
  }

  @override
  Future<TenantDetail> tenant(String orgId) async {
    _guard();
    return TenantDetail.fromJson(await _api.get('/mobile/admin/tenants/$orgId'));
  }

  @override
  Future<void> suspend(String orgId, {String? reason}) async {
    _guard();
    await _api.post(
      '/mobile/admin/tenants/$orgId/suspend',
      body: {if (reason != null && reason.trim().isNotEmpty) 'reason': reason.trim()},
    );
  }

  @override
  Future<void> reactivate(String orgId) async {
    _guard();
    await _api.post('/mobile/admin/tenants/$orgId/reactivate');
  }

  @override
  Future<void> emailOwner(String orgId, {required String subject, required String body}) async {
    _guard();
    await _api.post(
      '/mobile/admin/tenants/$orgId/email',
      body: {'subject': subject, 'body': body},
    );
  }

  @override
  Future<void> overrideBilling(String orgId, BillingOverride change) async {
    _guard();
    await _api.post('/mobile/admin/tenants/$orgId/billing', body: change.toJson());
  }

  @override
  Future<List<AdminPayment>> paymentQueue() async {
    _guard();
    final json = await _api.get('/mobile/admin/payments');
    return [for (final p in _list(json['payments'])) AdminPayment.fromJson(p)];
  }

  @override
  Future<void> approvePayment(String paymentId) async {
    _guard();
    await _api.post('/mobile/admin/payments/$paymentId/approve');
  }

  @override
  Future<void> rejectPayment(String paymentId, {String? note}) async {
    _guard();
    await _api.post(
      '/mobile/admin/payments/$paymentId/reject',
      body: {if (note != null && note.trim().isNotEmpty) 'note': note.trim()},
    );
  }

  @override
  Future<InstapaySettings> instapay() async {
    _guard();
    return InstapaySettings.fromJson(await _api.get('/mobile/admin/billing-config'));
  }

  @override
  Future<InstapaySettings> saveInstapay({
    required String payee,
    required String account,
    List<int>? qrImage,
    bool clearQr = false,
  }) async {
    _guard();
    // The server treats an empty field as "clear it", so keeping the current
    // QR means sending it back. A new one travels as a data URL and is stored
    // server-side.
    final String qrUrl;
    if (qrImage != null) {
      qrUrl = 'data:image/jpeg;base64,${base64Encode(qrImage)}';
    } else if (clearQr) {
      qrUrl = '';
    } else {
      qrUrl = (await instapay()).qrUrl ?? '';
    }
    return InstapaySettings.fromJson(await _api.put(
      '/mobile/admin/billing-config',
      body: {'qrUrl': qrUrl, 'payee': payee.trim(), 'account': account.trim()},
    ));
  }

  @override
  Future<List<AuditEntry>> audit({int limit = 100}) async {
    _guard();
    final json = await _api.get('/mobile/admin/audit', query: {'limit': '$limit'});
    return [for (final e in _list(json['entries'])) AuditEntry.fromJson(e)];
  }

  @override
  Future<List<PlatformAdminEntry>> admins() async {
    _guard();
    final json = await _api.get('/mobile/admin/admins');
    return [for (final a in _list(json['admins'])) PlatformAdminEntry.fromJson(a)];
  }

  @override
  Future<void> revokeAdmin(String userId) async {
    _guard();
    await _api.post('/mobile/admin/admins/$userId/revoke');
  }
}
