import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/home.dart';
import 'package:mealkit/loginpage.dart';
import 'package:mealkit/registration.dart';
//include loginpage

void testLogin(WidgetTester tester) async {

//-----------------------------build the sample page-----------------------------------------//
   await tester.pumpWidget(MaterialApp(
      home: Login(), //replace with login page
    ));

//----------------------------find and store UI elements on the Page----------------------------------//
//replace with labels in the login file
    Finder usernameField = find.byKey(Key('username_field'));
    Finder passwordField = find.byKey(Key('password_field'));

//---------------------------verify UI elements----------------------------------------------------//
    expect(usernameField, findsOneWidget);
    expect(passwordField, findsOneWidget);

    expect(usernameField, isInstanceOf<TextField>());
    expect(passwordField, isInstanceOf<TextField>());
    //replace login
    

//----------------------do not proceed if the fields are empty------------------------------------//
   
    expect((tester.widget(usernameField) as TextField).controller?.text, '');
    expect((tester.widget(passwordField) as TextField).controller?.text, '');
    expect(find.widgetWithText(TextButton, 'Sign In'), findsOneWidget);

    // Tap the "Login" button to trigger the popup
    await tester.tap(find.widgetWithText(TextButton, 'Sign In'));

    // Wait for the animation to complete
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(HomeView), findsOneWidget);

//------------------proceed if all the fileds are filled----------------------------------------//
    await tester.enterText(usernameField, 'example_username');
    await tester.enterText(passwordField, 'example_password');

    expect(find.widgetWithText(TextButton, 'Sign In'), findsOneWidget);

    // Tap the "Login" button to trigger the popup
    await tester.tap(find.widgetWithText(TextButton, 'Sign In'));

    // Wait for the animation to complete
    await tester.pumpAndSettle();

    // Verify that the popup dialog appears
    expect(find.byType(AlertDialog), findsOneWidget);

    // Verify the text content of the popup
    expect(find.text('Login Complete'), findsOneWidget);

    // Optionally, you can also verify other elements in the popup dialog

    // Close the popup dialog by tapping outside the dialog
    await tester.tap(find.byType(AlertDialog));
    await tester.pumpAndSettle();

    // Verify that the popup dialog is dismissed
    expect(find.byType(AlertDialog), findsNothing);
  
  //-----------------sign up------------------------------------------//

    final signUpButtonFinder = find.widgetWithText(TextButton, "Don't have an Account? Sign Up!");

    // Tap the "Don't have an Account? Sign Up!" button
    await tester.tap(signUpButtonFinder);

    // Wait for the navigation transition to complete
    await tester.pumpAndSettle();

    // Verify that the Registration page is displayed
    expect(find.byType(Registration), findsOneWidget);
}
