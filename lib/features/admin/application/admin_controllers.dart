import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../admin_providers.dart';
import '../domain/admin.dart';

part 'admin_controllers.g.dart';

/// The console's reads. None are cached for offline: every one of them is
/// somebody else's money or access, and yesterday's copy of it is worse than
/// an error that says so.

@riverpod
Future<AdminOverview> adminOverview(Ref ref) => ref.watch(adminRepositoryProvider).overview();

@riverpod
Future<List<TenantSummary>> adminTenants(Ref ref, String query) =>
    ref.watch(adminRepositoryProvider).tenants(query: query);

@riverpod
Future<TenantDetail> adminTenant(Ref ref, String orgId) =>
    ref.watch(adminRepositoryProvider).tenant(orgId);

@riverpod
Future<List<AdminPayment>> adminPaymentQueue(Ref ref) =>
    ref.watch(adminRepositoryProvider).paymentQueue();

@riverpod
Future<InstapaySettings> adminInstapay(Ref ref) => ref.watch(adminRepositoryProvider).instapay();

@riverpod
Future<List<AuditEntry>> adminAudit(Ref ref) => ref.watch(adminRepositoryProvider).audit();

@riverpod
Future<List<PlatformAdminEntry>> adminAdmins(Ref ref) =>
    ref.watch(adminRepositoryProvider).admins();

/// The console's writes. Each refreshes what it changed — and the overview
/// and audit trail, which every write changes.
///
/// `keepAlive` because these are invoked with `ref.read` from a button: an
/// auto-dispose notifier is gone before the future completes.
@Riverpod(keepAlive: true)
class AdminCommands extends _$AdminCommands {
  @override
  void build() {}

  AdminRepository get _repo => ref.read(adminRepositoryProvider);

  void _touched({String? orgId}) {
    ref
      ..invalidate(adminOverviewProvider)
      ..invalidate(adminAuditProvider)
      ..invalidate(adminTenantsProvider);
    if (orgId != null) ref.invalidate(adminTenantProvider(orgId));
  }

  Future<void> suspend(String orgId, {String? reason}) async {
    await _repo.suspend(orgId, reason: reason);
    _touched(orgId: orgId);
  }

  Future<void> reactivate(String orgId) async {
    await _repo.reactivate(orgId);
    _touched(orgId: orgId);
  }

  Future<void> emailOwner(String orgId, {required String subject, required String body}) async {
    await _repo.emailOwner(orgId, subject: subject, body: body);
    ref.invalidate(adminAuditProvider);
  }

  Future<void> overrideBilling(String orgId, BillingOverride change) async {
    await _repo.overrideBilling(orgId, change);
    _touched(orgId: orgId);
  }

  Future<void> approvePayment(AdminPayment payment) async {
    await _repo.approvePayment(payment.id);
    ref.invalidate(adminPaymentQueueProvider);
    _touched(orgId: payment.orgId);
  }

  Future<void> rejectPayment(AdminPayment payment, {String? note}) async {
    await _repo.rejectPayment(payment.id, note: note);
    ref.invalidate(adminPaymentQueueProvider);
    _touched(orgId: payment.orgId);
  }

  Future<void> saveInstapay({
    required String payee,
    required String account,
    List<int>? qrImage,
    bool clearQr = false,
  }) async {
    await _repo.saveInstapay(
      payee: payee,
      account: account,
      qrImage: qrImage,
      clearQr: clearQr,
    );
    ref
      ..invalidate(adminInstapayProvider)
      ..invalidate(adminAuditProvider);
  }

  Future<void> revokeAdmin(String userId) async {
    await _repo.revokeAdmin(userId);
    ref
      ..invalidate(adminAdminsProvider)
      ..invalidate(adminAuditProvider);
  }
}
