// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:va_task/view/home.dart';

void main() {

  testWidgets('Add and remove a todo', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const Home());

    // Enter 'hi' into the TextField.
    await tester.enterText(find.byType(TextField), 'hi');

    await tester.pump();
  });

  testWidgets('Add and remove a todo', (WidgetTester tester) async {
    // Enter text code...

    await tester.pumpWidget(const Home());
    // Tap the add button.
    await tester.tap(find.byType(ElevatedButton));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Expect to find the item on screen.
    //expect(find.text('hi'), findsOneWidget);
  });
}
