import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/checkout.dart';

void main() {
  group('CheckoutPage Widget Tests', () {
    testWidgets('Checkout Page Rendering Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CheckoutPage(),
      ));

      expect(find.text('Checkout'), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      expect(find.text('Your Orders:'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Submit Order Button Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CheckoutPage(),
      ));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify that the success dialog is shown
      expect(find.text('Success'), findsOneWidget);
      expect(find.text('Orders submitted successfully.'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);

      // Tap on OK button to close the dialog
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // Verify that the dialog is closed and navigated to the home page
      expect(find.text('Success'), findsNothing);
      expect(find.text('Orders submitted successfully.'), findsNothing);
      expect(find.text('OK'), findsNothing);
      expect(find.text('Checkout'), findsNothing);
      expect(find.byType(Form), findsNothing);
      expect(find.text('Your Orders:'), findsNothing);
      expect(find.byType(ElevatedButton), findsNothing);
    });
  });
}
