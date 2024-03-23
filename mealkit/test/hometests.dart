import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/navigation.dart';
import 'package:mealkit/home.dart';
import 'package:carousel_slider/carousel_slider.dart';


void testHomeUI(WidgetTester tester) async
{
    await tester.pumpWidget(MaterialApp(
      home: HomeView(),
    ));

    // Verify the appearance of the AppBar
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget); //replace home with website name 

    expect(find.byType(CarouselSlider), findsOneWidget);

    //verifying that carousel works fine
    expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == 'assets/image1.jpg'), findsOneWidget);

    // Swipe to the next image in the CarouselSlider
    final screenWidth = MediaQuery.of(tester.element(find.byType(CarouselSlider))).size.width;
    final itemWidth = screenWidth * 0.9; // Assuming viewportFraction is set to 0.9
    final swipeOffset = -(itemWidth + (screenWidth * 0.1)); // Calculate the offset for swiping to the next item

    await tester.drag(find.byType(CarouselSlider), Offset(swipeOffset, 0));
    await tester.pumpAndSettle(); // Wait for animation to complete

    // Verify the next image
    expect(find.byWidgetPredicate((widget) => widget is Image && widget.image is AssetImage && (widget.image as AssetImage).assetName == 'assets/image2.jpg'), findsOneWidget);

    // Repeat the above steps for other images if needed - when images are finalized
}

void testCartButton(WidgetTester tester) async
{
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Navigationbar(), // Render Navigationbar on the screen for testing
      ),
      // routes: {
      //   '/cart': (context) => CartPage(), // replace cartpage with the class that defines that page
      // },
    ));

    // Find the cart button
    final Finder cartButtonFinder = find.byIcon(Icons.shopping_cart);

    // Tap the cart button
    await tester.tap(cartButtonFinder);
    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Verify if navigation to cart page occurred
    expect(find.text('Cart'), findsOneWidget); //replace cart with unique word on the page
}

void testLoginButton(WidgetTester tester) async
{
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Navigationbar(), // Render Navigationbar on the screen for testing
      ),
      // routes: {
      //   '/login': (context) => LoginPage(), // replace LoginPage with the class that defines the page
      // },
    ));

    // Find the login button
    final Finder LoginButtonFinder = find.text('Login');

    // Tap the login button
    await tester.tap(LoginButtonFinder);
    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Verify if navigation to login page occurred
    expect(find.text('Login'), findsOneWidget); //replace login with unique word on the page
}