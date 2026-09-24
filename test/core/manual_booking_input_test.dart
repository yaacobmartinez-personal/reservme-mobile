import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/features/venue/calendar/domain/manual_booking_input.dart';

void main() {
  ManualBookingInput input({
    int slotCount = 1,
    int partySize = 1,
    String? notes,
    String? customerId,
    String? name,
    String? email,
    String? phone,
    String date = '2026-09-26',
    String time = '19:00',
  }) =>
      ManualBookingInput(
        spaceId: 'sp_1',
        date: date,
        time: time,
        slotCount: slotCount,
        partySize: partySize,
        notes: notes,
        customerId: customerId,
        name: name,
        email: email,
        phone: phone,
      );

  group('manual booking', () {
    test('an existing customer needs nothing else', () {
      expect(input(customerId: 'c_1').validate(), isNull);
    });

    test('a walk-in needs a name and an email', () {
      expect(
        input().validate(),
        'Choose a customer, or enter a name and email.',
      );
      expect(
        input(name: 'Ana Reyes').validate(),
        'Choose a customer, or enter a name and email.',
      );
      expect(input(name: 'Ana Reyes', email: 'ana@example.com').validate(), isNull);
    });

    test('an obviously wrong email is refused before the request', () {
      expect(
        input(name: 'Ana', email: 'ana@example').validate(),
        'Please check the booking details.',
      );
    });

    test('slots are 1–24 and party 1–500, exactly as the web schema', () {
      expect(input(customerId: 'c_1', slotCount: 24).validate(), isNull);
      expect(input(customerId: 'c_1', slotCount: 25).validate(), isNotNull);
      expect(input(customerId: 'c_1', slotCount: 0).validate(), isNotNull);
      expect(input(customerId: 'c_1', partySize: 500).validate(), isNull);
      expect(input(customerId: 'c_1', partySize: 501).validate(), isNotNull);
    });

    test('notes stop at 500 characters', () {
      expect(input(customerId: 'c_1', notes: 'x' * 500).validate(), isNull);
      expect(input(customerId: 'c_1', notes: 'x' * 501).validate(), isNotNull);
    });

    test('a malformed date or time is caught here, not on the server', () {
      expect(input(customerId: 'c_1', date: '26-09-2026').validate(),
          "That start time isn't valid.");
      expect(input(customerId: 'c_1', time: '7pm').validate(),
          "That start time isn't valid.");
    });

    test('the payload trims and lower-cases the way zod does', () {
      final json = input(
        name: '  Ana Reyes ',
        email: '  ANA@Example.COM ',
        phone: ' 0917 555 0301 ',
        notes: '  bring shuttles  ',
      ).toJson();

      expect(json['name'], 'Ana Reyes');
      expect(json['email'], 'ana@example.com');
      expect(json['phone'], '0917 555 0301');
      expect(json['notes'], 'bring shuttles');
      expect(json.containsKey('customerId'), isFalse);
    });

    test('a chosen customer wins over typed details', () {
      final json = input(customerId: 'c_1', name: 'Ana', email: 'a@b.co').toJson();

      expect(json['customerId'], 'c_1');
      expect(json.containsKey('name'), isFalse);
      expect(json.containsKey('email'), isFalse);
    });
  });

  group('block off', () {
    BlockInput block({String from = '18:00', String to = '20:00', String? reason}) =>
        BlockInput(date: '2026-09-26', from: from, to: to, reason: reason);

    test('a normal window is fine, with or without a space', () {
      expect(block().validate(), isNull);
      expect(
        BlockInput(spaceId: 'sp_1', date: '2026-09-26', from: '09:00', to: '10:00')
            .validate(),
        isNull,
      );
    });

    test('the end must be after the start', () {
      expect(block(from: '20:00', to: '18:00').validate(),
          'The end must be after the start.');
      expect(block(from: '18:00', to: '18:00').validate(),
          'The end must be after the start.');
    });

    test('a malformed time is refused', () {
      expect(block(from: '6pm').validate(), 'Please give a valid start and end.');
    });

    test('the reason stops at 200 characters', () {
      expect(block(reason: 'x' * 200).validate(), isNull);
      expect(block(reason: 'x' * 201).validate(), 'Please give a valid range.');
    });

    test('no space means the whole venue, and the payload says so by omission', () {
      expect(block().toJson().containsKey('spaceId'), isFalse);
      expect(
        BlockInput(spaceId: 'sp_1', date: '2026-09-26', from: '1', to: '2')
            .toJson()['spaceId'],
        'sp_1',
      );
    });
  });
}
