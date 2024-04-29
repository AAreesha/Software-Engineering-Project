import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/navigation.dart';
import 'package:mealkit/registration.dart';

void main() {
  group('Registration Widget Tests', () {
    testWidgets('Registration Page Rendering Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Registration(),
      ));

      expect(find.text('Registration'), findsOneWidget);
      expect(find.byType(Navigationbar), findsOneWidget);
      expect(find.byType(MyCustomForm), findsOneWidget);
    });

    testWidgets('Registration Form Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Registration(),
      ));

      expect(find.byKey(ValueKey('username_field')), findsOneWidget);
      expect(find.byKey(ValueKey('email_field')), findsOneWidget);
      expect(find.byKey(ValueKey('password_field')), findsOneWidget);
      expect(find.byKey(ValueKey('contact_field')), findsOneWidget);
      expect(find.byKey(ValueKey('address_field')), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('Registration Dialog Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Registration(),
      ));

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(find.text('Registration Complete'), findsOneWidget);
    });
  });
}
