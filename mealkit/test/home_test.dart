import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/home.dart'; // Replace this with the correct import path
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mealkit/screens/wrapper.dart';

void main() {
  testWidgets('Test Carousel Functionality', (WidgetTester tester) async {
    // Build the HomeView widget
    await tester.pumpWidget(MaterialApp(home: HomeView()));

    // Scroll through the carousel
    await tester.drag(find.byType(CarouselSlider), Offset(-400, 0));
    await tester.pump();

    // Verify that the images and text in the carousel change as expected
    expect(find.text('Great food, excellent service!'), findsOneWidget);
  });

  testWidgets('Test Best Sellers Section', (WidgetTester tester) async {
    // Build the HomeView widget
    await tester.pumpWidget(MaterialApp(home: HomeView()));

    // Check if the best sellers section is displayed correctly
    expect(find.text('Best Sellers'), findsOneWidget);
    expect(find.text('Product 1'), findsOneWidget);
    expect(find.text('Product 2'), findsOneWidget);
    expect(find.text('Product 3'), findsOneWidget);
  });

  testWidgets('Test Additional Section', (WidgetTester tester) async {
    // Build the HomeView widget
    await tester.pumpWidget(MaterialApp(home: HomeView()));

    // Check if the additional section is displayed correctly
    expect(find.text('Meal Kits that fit your needs'), findsOneWidget);
    expect(find.text('Customize your own meals'), findsOneWidget);
    expect(find.text('Fresh,pre-portioned ingredients'), findsOneWidget);
  });

  testWidgets('Test Navigation Button', (WidgetTester tester) async {
    // Build the HomeView widget
    await tester.pumpWidget(MaterialApp(home: HomeView()));

    // Tap on the "Get Started" button
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify that tapping the button navigates to the intended page
    expect(find.byType(Wrapper), findsOneWidget); // Assuming Wrapper is the intended page
  });

  testWidgets('Test Title Row', (WidgetTester tester) async {
    // Build the HomeView widget
    await tester.pumpWidget(MaterialApp(home: HomeView()));

    // Check if the title row is displayed correctly
    expect(find.text('Services'), findsOneWidget);
    expect(find.text('Resources'), findsOneWidget);
    expect(find.text('Company'), findsOneWidget);
  });

  testWidgets('Test Content Row', (WidgetTester tester) async {
    // Build the HomeView widget
    await tester.pumpWidget(MaterialApp(home: HomeView()));

    // Check if the content row is displayed correctly
    expect(find.text('Our Menu'), findsOneWidget);
    expect(find.text('How it Works'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('FAQs'), findsOneWidget);
    expect(find.text('Recipe Categories'), findsOneWidget);
    expect(find.text('Terms and Conditions'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('About Us'), findsOneWidget);
    expect(find.text('Press'), findsOneWidget);
    expect(find.text('Legal'), findsOneWidget);
  });
}
