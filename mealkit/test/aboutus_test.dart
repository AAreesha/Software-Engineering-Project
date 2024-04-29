import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/about.dart'; // Replace this with the correct import path

void main() {
  testWidgets('Test About Us Page Title', (WidgetTester tester) async {
    // Build the AboutUsPage widget
    await tester.pumpWidget(MaterialApp(home: AboutUsPage()));

    // Check if the title is displayed correctly
    expect(find.text('Welcome to Your Meal Kit Company!'), findsOneWidget);
  });

  testWidgets('Test About Us Page Mission', (WidgetTester tester) async {
    // Build the AboutUsPage widget
    await tester.pumpWidget(MaterialApp(home: AboutUsPage()));

    // Check if the mission section is displayed correctly
    expect(find.text('Our Mission:'), findsOneWidget);
    expect(find.text('Our mission is to provide convenient, nutritious, and flavorful meal kits that inspire people to cook at home and enjoy the experience of preparing and sharing meals with their loved ones.'), findsOneWidget);
  });

  testWidgets('Test About Us Page Points', (WidgetTester tester) async {
    // Build the AboutUsPage widget
    await tester.pumpWidget(MaterialApp(home: AboutUsPage()));

    // Check if the points section is displayed correctly
    expect(find.text('Why Choose Us?'), findsOneWidget);
    expect(find.text('Using fresh, high-quality ingredients sourced from local farmers and suppliers.'), findsOneWidget);
    expect(find.text('Offering a wide variety of recipes to suit different tastes and dietary preferences, including vegetarian, vegan, and gluten-free options.'), findsOneWidget);
    expect(find.text('Providing step-by-step recipes and pre-portioned ingredients to make cooking hassle-free and enjoyable.'), findsOneWidget);
    expect(find.text('Ensuring sustainable practices in packaging and delivery to minimize our environmental footprint.'), findsOneWidget);
    expect(find.text('Offering flexible subscription plans that fit your lifestyle and schedule.'), findsOneWidget);
    expect(find.text('Delivering exceptional customer service and support.'), findsOneWidget);
  });
}
