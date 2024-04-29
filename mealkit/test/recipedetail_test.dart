import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/recipedetail.dart';

void main() {
  group('RecipeDetailPage Widget Tests', () {
    testWidgets('Rendering Test', (WidgetTester tester) async {
      final String title = 'Test Recipe';
      final String description = 'This is a test recipe description.';

      await tester.pumpWidget(MaterialApp(
        home: RecipeDetailPage(title, description),
      ));

      expect(find.text(title), findsOneWidget);
      expect(find.text(description), findsOneWidget);
    });

    testWidgets('Tab Navigation Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: RecipeDetailPage('Test Recipe', 'Test Description'),
      ));

      expect(find.text('Ingredients'), findsOneWidget);
      expect(find.text('Instructions'), findsOneWidget);
    });

    testWidgets('Ingredients Tab Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: RecipeDetailPage('Test Recipe', 'Test Description'),
      ));

      await tester.tap(find.text('Ingredients'));
      await tester.pumpAndSettle();

      expect(find.text('Ingredients for Test Recipe'), findsOneWidget);
      expect(find.text('List of ingredients goes here...'), findsOneWidget);
    });

    testWidgets('Instructions Tab Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: RecipeDetailPage('Test Recipe', 'Test Description'),
      ));

      await tester.tap(find.text('Instructions'));
      await tester.pumpAndSettle();

      expect(find.text('Instructions for Test Recipe'), findsOneWidget);
      expect(find.text('Recipe instructions go here...'), findsOneWidget);
    });

    testWidgets('Navigation Bar Test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: RecipeDetailPage('Test Recipe', 'Test Description'),
      ));

      expect(find.text('Test Recipe'), findsOneWidget);
      expect(find.byType(BackButton), findsNothing);
    });
  });
}
