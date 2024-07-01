import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:testambient/main.dart';

void main() {
  testWidgets('TimerScreen increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our timer starts at 00:00:00.
    expect(find.text('00:00:00'), findsOneWidget);
    expect(find.text('00:00:01'), findsNothing);

    // Tap the 'Start' button and trigger a frame.
    await tester.tap(find.text('Start'));
    await tester.pump();

    // Wait for one second.
    await tester.pump(const Duration(seconds: 1));

    // Verify that our timer has incremented.
    expect(find.text('00:00:00'), findsNothing);
    expect(find.text('00:00:01'), findsOneWidget);

    // Tap the 'Stop' button and trigger a frame.
    await tester.tap(find.text('Stop'));
    await tester.pump();

    // Wait for another second.
    await tester.pump(const Duration(seconds: 1));

    // Verify that our timer has not incremented.
    expect(find.text('00:00:01'), findsOneWidget);
    expect(find.text('00:00:02'), findsNothing);

    // Tap the 'Reset' button and trigger a frame.
    await tester.tap(find.text('Reset'));
    await tester.pump();

    // Verify that our timer has reset.
    expect(find.text('00:00:00'), findsOneWidget);
    expect(find.text('00:00:01'), findsNothing);
  });
}
