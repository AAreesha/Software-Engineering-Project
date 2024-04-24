import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/navigation.dart';
import 'package:mealkit/home.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mealkit/loginpage.dart';

void testHomeUI(WidgetTester tester) async
{
//----------------------------create a sample page-------------------------------------//
    await tester.pumpWidget(MaterialApp(
      home: HomeView(),
    ));

    
//-------------------------check UI elements------------------------------------------//
  //-------------------navigation bar--------------------------//
    expect(find.byType(AppBar), findsOneWidget);
    
    // expect(find.text('Home'), findsOneWidget); //replace home with website name
    expect(find.text('Login'), findsNWidgets(2)); //because the page has two login texts
    expect(find.text('Menu'),findsOneWidget);
    expect(find.text('Voucher'), findsOneWidget);
    expect(find.text('About Us'), findsNWidgets(2)); //two about us on the page
    expect(find.byIcon(Icons.shopping_cart), findsOneWidget);

  //-------------------------carousel-------------------------//
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

  //------------------------best sellers-------------------------//
    //assuming that the bestsellers are named as best-seller-image and best-seller-description and that there will always be 3

  //   expect(find.byWidgetPredicate((widget) => widget is Container && widget.color == Colors.green), findsOneWidget); //change color

  //   expect(find.text('Best Sellers'), findsOneWidget);

  //   expect(find.byKey(Key('best_seller_image')), findsNWidgets(3));
  //   expect(find.byKey(Key('best_seller_description')), findsNWidgets(3));
  
  // //-----------------------description--------------------------//

  //   expect(find.byWidgetPredicate((widget) => widget is Container && widget.color == Colors.green), findsOneWidget);

  //   expect(find.byWidgetPredicate(
  //     (widget) =>
  //         widget is Image &&
  //         widget.image is AssetImage &&
  //         (widget.image as AssetImage).assetName == 'assets/best_seller_image.jpg', //chef
  //   ), findsOneWidget);
  //   expect(find.text('Meal Kits that fit your needs.'), findsOneWidget);

  //   expect(find.byWidgetPredicate(
  //     (widget) =>
  //         widget is Image &&
  //         widget.image is AssetImage &&
  //         (widget.image as AssetImage).assetName == 'assets/best_seller_image.jpg', //notebook
  //   ), findsOneWidget);
  //   expect(find.text('Customize your own Meals.'), findsOneWidget);

  //   expect(find.byWidgetPredicate(
  //     (widget) =>
  //         widget is Image &&
  //         widget.image is AssetImage &&
  //         (widget.image as AssetImage).assetName == 'assets/best_seller_image.jpg', //spoon fork
  //   ), findsOneWidget);
  //   expect(find.text('Fresh, pre-portioned ingredients'), findsOneWidget);
  
  // //-----------------------Reviews-----------------------------------//
  //   expect(find.byWidgetPredicate((widget) => widget is Container && widget.color == Colors.green), findsOneWidget); //change color

  //-----------------------Contact-----------------------------------//
    expect(find.byWidgetPredicate((widget) => widget is Container && widget.color == Colors.green), findsOneWidget);
    //login, about us checked already
    expect(find.text('Services'), findsOneWidget); 
    expect(find.text('Our Menu'), findsOneWidget);
    expect(find.text('How it Works'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Resources'), findsOneWidget); 
    expect(find.text('FAQs'), findsOneWidget);
    expect(find.text('Recipe Categories'), findsOneWidget);
    expect(find.text('Terms and Conditions'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget); 
    expect(find.text('Company'), findsOneWidget);
    expect(find.text('Press'), findsOneWidget);
    expect(find.text('Legal'), findsOneWidget);
    //check for phone number and social media handles + the handles connect to links
}

void testCartButton(WidgetTester tester) async
{
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Navigationbar(total: 0.0,cartItems: [],), // Render Navigationbar on the screen for testing
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
        body: Navigationbar(total: 0.0,cartItems: [],), // Render Navigationbar on the screen for testing
      ),
      routes: {
        '/login': (context) => Login(), // replace LoginPage with the class that defines the page
      },
    ));

    // Find the login button
    final Finder LoginButtonFinder = find.text('Login');

    // Tap the login button
    await tester.tap(LoginButtonFinder);
    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Verify if navigation to login page occurred
    expect(find.text('Login'), findsOneWidget); //replace login with unique word on the page
}