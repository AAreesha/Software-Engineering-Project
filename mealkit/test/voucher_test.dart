import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/voucher.dart';

void main() {
  group('VoucherPage Widget Tests', () {
    testWidgets('Voucher Page Rendering Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: VoucherPage(),
      ));

      expect(find.text('Available Vouchers'), findsOneWidget);
      expect(find.text('New Vouchers'), findsOneWidget);
      expect(find.text('Used Vouchers'), findsOneWidget);
      expect(find.byType(ListView), findsNWidgets(3));
      expect(find.byType(Card), findsWidgets);
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('Voucher Card Tap Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: VoucherPage(),
      ));

      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      expect(find.text('Available Vouchers'), findsOneWidget);
      expect(find.text('New Vouchers'), findsOneWidget);
      expect(find.text('Used Vouchers'), findsOneWidget);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Code:'), findsOneWidget);
      expect(find.text('Details:'), findsOneWidget);
    });

    testWidgets('Voucher Card Tap Close Button Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: VoucherPage(),
      ));

      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();

      expect(find.text('Available Vouchers'), findsOneWidget);
      expect(find.text('New Vouchers'), findsOneWidget);
      expect(find.text('Used Vouchers'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });
  });
}
