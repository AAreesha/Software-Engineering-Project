import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//include loginpage

void testLoginUI(WidgetTester tester) async {
    // Build our app and trigger a frame
   await tester.pumpWidget(MaterialApp(
      // home: HomeView(), //replace with login page
    ));

    // Find the username, password text fields, and login button //replace with labels in the login file
    Finder usernameField = find.byKey(Key('username_field'));
    Finder passwordField = find.byKey(Key('password_field'));
    Finder loginButton = find.byKey(Key('login_button'));

    // Verify that all UI elements are present on the login page
    expect(usernameField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    // Verify that the correct widgets are used
    expect(usernameField, isInstanceOf<TextField>());
    expect(passwordField, isInstanceOf<TextField>());
    expect(loginButton, isInstanceOf<ElevatedButton>());

    // Verify the placeholder text of username and password fields
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    
    // Verify the presence of a login button with the correct text
    expect(find.text('Login'), findsOneWidget);
}

void testInputnotEmptyLogin(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(
      // home: HomeView(), //replace with login page
    ));

    // Find the username and password text fields + login button //replace with labels in the login file
    Finder usernameField = find.byKey(Key('username_field'));
    Finder passwordField = find.byKey(Key('password_field'));

    Finder loginButton = find.byKey(Key('login_button'));

    // Verify that both fields are initially empty
    expect((tester.widget(usernameField) as TextField).controller?.text, '');
    expect((tester.widget(passwordField) as TextField).controller?.text, '');

    // Tap on the login button without filling the fields
    await tester.tap(loginButton);
    await tester.pump();

    // Verify that the app doesn't proceed to the next page
    expect(find.text('Welcome'), findsNothing); //replace welcome with a keyword from the page that login button will load

    // Enter text into the username and password fields
    await tester.enterText(usernameField, 'example_username');
    await tester.enterText(passwordField, 'example_password');

    // Tap on the login button again
    await tester.tap(loginButton);
    await tester.pump();

    // Verify that the app proceeds to the next page
    expect(find.text('Welcome'), findsOneWidget); //replace welcome with a keyword from the page that login button will load
}
