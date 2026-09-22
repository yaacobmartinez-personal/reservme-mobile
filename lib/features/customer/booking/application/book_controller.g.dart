// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The contact details this phone remembers, so the booking form is
/// pre-filled after the first booking. Local only — never sent anywhere
/// until the customer books.

@ProviderFor(SavedContact)
final savedContactProvider = SavedContactProvider._();

/// The contact details this phone remembers, so the booking form is
/// pre-filled after the first booking. Local only — never sent anywhere
/// until the customer books.
final class SavedContactProvider
    extends $AsyncNotifierProvider<SavedContact, Contact> {
  /// The contact details this phone remembers, so the booking form is
  /// pre-filled after the first booking. Local only — never sent anywhere
  /// until the customer books.
  SavedContactProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedContactProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedContactHash();

  @$internal
  @override
  SavedContact create() => SavedContact();
}

String _$savedContactHash() => r'187ab3dd785b7396353d609ce4a1aa6aeaa1427d';

/// The contact details this phone remembers, so the booking form is
/// pre-filled after the first booking. Local only — never sent anywhere
/// until the customer books.

abstract class _$SavedContact extends $AsyncNotifier<Contact> {
  FutureOr<Contact> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Contact>, Contact>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Contact>, Contact>,
              AsyncValue<Contact>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Makes a booking and, on success, saves it to the device wallet and
/// remembers the contact details. The outcome is returned rather than
/// thrown — "that slot just went" is an answer, not an error.
/// Kept alive: the screen calls it through `ref.read` from a button, so an
/// auto-disposed provider would be gone before the result comes back.

@ProviderFor(BookController)
final bookControllerProvider = BookControllerProvider._();

/// Makes a booking and, on success, saves it to the device wallet and
/// remembers the contact details. The outcome is returned rather than
/// thrown — "that slot just went" is an answer, not an error.
/// Kept alive: the screen calls it through `ref.read` from a button, so an
/// auto-disposed provider would be gone before the result comes back.
final class BookControllerProvider
    extends $AsyncNotifierProvider<BookController, BookOutcome?> {
  /// Makes a booking and, on success, saves it to the device wallet and
  /// remembers the contact details. The outcome is returned rather than
  /// thrown — "that slot just went" is an answer, not an error.
  /// Kept alive: the screen calls it through `ref.read` from a button, so an
  /// auto-disposed provider would be gone before the result comes back.
  BookControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookControllerHash();

  @$internal
  @override
  BookController create() => BookController();
}

String _$bookControllerHash() => r'70c1516545f34b62f13c9a885b76b4a92883f202';

/// Makes a booking and, on success, saves it to the device wallet and
/// remembers the contact details. The outcome is returned rather than
/// thrown — "that slot just went" is an answer, not an error.
/// Kept alive: the screen calls it through `ref.read` from a button, so an
/// auto-disposed provider would be gone before the result comes back.

abstract class _$BookController extends $AsyncNotifier<BookOutcome?> {
  FutureOr<BookOutcome?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BookOutcome?>, BookOutcome?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BookOutcome?>, BookOutcome?>,
              AsyncValue<BookOutcome?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
