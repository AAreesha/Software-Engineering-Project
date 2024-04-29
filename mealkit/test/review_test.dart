import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/review.dart';

void main() {
  group('ReviewPage Widget Tests', () {
    testWidgets('Review Page Rendering Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ReviewPage(),
      ));

      expect(find.text('Customer Reviews'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('Review Page Navigation Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ReviewPage(),
      ));

      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });
  });
}
