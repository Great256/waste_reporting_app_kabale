
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:waste_reporting_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Counter decrements when "-" icon is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Increment once to avoid negative numbers if not allowed
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Tap the '-' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    // Verify that our counter is back to 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });

  testWidgets('Counter does not go below zero', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap the '-' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    // Verify that our counter is still at 0 (assuming no negative allowed).
    expect(find.text('0'), findsOneWidget);
    expect(find.text('-1'), findsNothing);
  });

  testWidgets('Multiple increments work correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap the '+' icon three times.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter is at 3.
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('UI contains increment and decrement buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.remove), findsOneWidget);
  });
}