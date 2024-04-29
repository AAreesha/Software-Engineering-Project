import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/menupage.dart';

void main() {
  group('MenuPage Widget Tests', () {
    testWidgets('MenuPage renders correctly', (WidgetTester tester) async {
      // Build the MenuPage widget
      await tester.pumpWidget(MenuPage());

      // Verify that the AppBar title is rendered
      expect(find.text('Menu'), findsOneWidget);

      // Verify that the search bar is rendered
      expect(find.byType(TextFormField), findsOneWidget);

      // Verify that cuisine sections are rendered
      expect(find.text('Korean'), findsOneWidget);
      expect(find.text('Indian'), findsOneWidget);
      expect(find.text('Italian'), findsOneWidget);
    });

    testWidgets('Add to cart functionality works', (WidgetTester tester) async {
      // Build the MenuPage widget
      await tester.pumpWidget(MenuPage());

      // Tap on the first recipe button to trigger the dialog
      await tester.tap(find.text('Kimchi Stew').first);

      // Wait for the dialog to appear
      await tester.pumpAndSettle();

      // Verify that the dialog is rendered
      expect(find.text('Kimchi Stew'), findsOneWidget);

      // Tap on the 'Add to Cart' button
      await tester.tap(find.text('Add to Cart'));

      // Verify that the item is added to the cart
      // You can add expectations based on your implementation
    });
  });
}
