import 'package:emobile_calculator_test/misc/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:emobile_calculator_test/main.dart';

void main() {
  group('Calculate From Expression Use Case', () {
    setUpAll(() {
      Injector.init();
    });

    testWidgets('Basic operations', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('7'));
      await tester.tap(find.text('+'));
      await tester.tap(find.text('3'));
      await tester.tap(find.text('='));
      await tester.pump();

      expect(find.widgetWithText(TextField, '10'), findsOneWidget);
    });

    testWidgets('Subtraction', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('9'));
      await tester.tap(find.text('-'));
      await tester.tap(find.text('5'));
      await tester.tap(find.text('='));
      await tester.pump();

      expect(find.widgetWithText(TextField, '4'), findsOneWidget);
    });

    testWidgets('Multiplication', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('6'));
      await tester.tap(find.text('*'));
      await tester.tap(find.text('4'));
      await tester.tap(find.text('='));
      await tester.pump();

      expect(find.widgetWithText(TextField, '24'), findsOneWidget);
    });

    testWidgets('Division', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('8'));
      await tester.tap(find.text('/'));
      await tester.tap(find.text('2'));
      await tester.tap(find.text('='));
      await tester.pump();

      expect(find.widgetWithText(TextField, '4'), findsOneWidget);
    });

    testWidgets('Complex expressions', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('('));
      await tester.tap(find.text('2'));
      await tester.tap(find.text('+'));
      await tester.tap(find.text('3'));
      await tester.tap(find.text(')'));
      await tester.tap(find.text('*'));
      await tester.tap(find.text('4'));
      await tester.tap(find.text('='));
      await tester.pump();

      expect(find.widgetWithText(TextField, '20'), findsOneWidget);
    });
  });
}
