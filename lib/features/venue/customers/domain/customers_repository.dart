import 'customer.dart';

/// Customers and their CRM (API-CONTRACT #20–#22).
///
/// Email is deliberately not editable: it is the (venue, email) identity key
/// the booking engine matches returning customers on, so changing it would
/// split one person into two. Name and phone only — same as the web.
abstract class CustomersRepository {
  Future<CustomerPage> list(
    String venueSlug, {
    String? search,
    CustomerSegment segment = CustomerSegment.all,
  });

  Future<CustomerProfile> detail(String venueSlug, String customerId);

  Future<CustomerNote> addNote(String venueSlug, String customerId, String body);

  Future<void> deleteNote(String venueSlug, String customerId, String noteId);

  /// Replaces the whole tag set (API-CONTRACT #22 `PUT …/tags`).
  Future<CustomerSummary> setTags(
    String venueSlug,
    String customerId,
    List<String> tags,
  );

  Future<CustomerSummary> updateContact(
    String venueSlug,
    String customerId, {
    required String name,
    String? phone,
  });
}

/// Tag rules from the web's `tagSchema`, applied before the request so the
/// chip editor can refuse in place.
abstract final class TagRules {
  static const max = 20;
  static final _allowed = RegExp(r'^[\p{L}\p{N} .&-]+$', unicode: true);

  /// The server's own message, or null when the tag is fine.
  static String? validate(String tag, List<String> existing) {
    final t = tag.trim();
    if (t.isEmpty) return "Tag can't be empty.";
    if (t.length > 30) return 'Keep tags under 30 characters.';
    if (!_allowed.hasMatch(t)) {
      return 'Tags can use letters, numbers, spaces and - . &';
    }
    if (existing.any((e) => e.toLowerCase() == t.toLowerCase())) {
      return 'That tag is already on this customer.';
    }
    if (existing.length >= max) return 'That is as many tags as one customer can have.';
    return null;
  }
}

/// Note rules from `addCustomerNote`.
abstract final class NoteRules {
  static String? validate(String body) {
    final b = body.trim();
    if (b.isEmpty) return 'Write something first.';
    if (b.length > 2000) return 'That note is too long.';
    return null;
  }
}

/// Contact rules from `updateCustomerContact`.
abstract final class ContactRules {
  static String? validate({required String name, String? phone}) {
    if (name.trim().isEmpty) return "Name can't be empty.";
    if (name.trim().length > 120) return 'That name is too long.';
    if ((phone ?? '').trim().length > 40) return 'That phone number is too long.';
    return null;
  }
}
