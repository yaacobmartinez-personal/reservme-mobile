import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reservme/core/config/app_config.dart';
import 'package:reservme/features/auth/presentation/login_screen.dart';
import 'package:reservme/features/customer/account/presentation/account_screen.dart';

import '../helpers/fakes.dart';
import '../helpers/pump_app.dart';

/// Tall, so every row is built: a row below the fold is never laid out, and a
/// finder that misses it passes for the wrong reason.
const _tall = Size(1080, 7200);

void main() {
  // 1.0 is the Huawei this broke on: a 360pt screen at normal text size read
  // "Appeara / nce" beside the segmented control. At 1.3 the old row did not
  // lay out at all.
  for (final scale in [1.0, 1.3]) {
    testWidgets('Appearance stays on one line at 360pt, text x$scale', (
      tester,
    ) async {
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await pumpApp(
        tester,
        const AccountScreen(),
        world: TestWorld(),
        surface: _tall,
      );
      await tester.pumpAndSettle();

      final label = find.text('Appearance');
      expect(label, findsOneWidget);
      final paragraph = tester.renderObject<RenderParagraph>(label);
      final boxes = paragraph.getBoxesForSelection(
        const TextSelection(baseOffset: 0, extentOffset: 'Appearance'.length),
      );
      final rows = boxes.map((box) => box.top.round()).toSet();
      expect(rows, hasLength(1), reason: 'the label must not wrap mid-word');
      expect(find.text('Dark'), findsOneWidget);
    });
  }

  testWidgets('Account says nothing about the server', (tester) async {
    await pumpApp(
      tester,
      const AccountScreen(),
      world: TestWorld(),
      surface: _tall,
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Server'), findsNothing);
    expect(find.textContaining('API'), findsNothing);
  });

  testWidgets('sign-in says nothing about the server', (tester) async {
    await pumpApp(
      tester,
      const LoginScreen(),
      world: TestWorld(),
      surface: _tall,
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Server'), findsNothing);
  });

  test('the version line names demo data only in a fake build', () {
    expect(versionLine(ApiMode.real), 'ReservMe ${AppConfig.appVersion}');
    expect(versionLine(ApiMode.fake), contains('demo data'));
  });
}
