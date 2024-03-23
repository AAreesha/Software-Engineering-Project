import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//include loginpage

void testLogin(WidgetTester tester) async {

//-----------------------------build the sample page-----------------------------------------//
   await tester.pumpWidget(MaterialApp(
      // home: HomeView(), //replace with login page
    ));

//----------------------------find and store UI elements on the Page----------------------------------//
//replace with labels in the login file
    Finder usernameField = find.byKey(Key('username_field'));
    Finder passwordField = find.byKey(Key('password_field'));
    Finder loginButton = find.byKey(Key('login_button'));

//---------------------------verify UI elements----------------------------------------------------//
    expect(usernameField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    expect(usernameField, isInstanceOf<TextField>());
    expect(passwordField, isInstanceOf<TextField>());
    expect(loginButton, isInstanceOf<ElevatedButton>());
    //replace login
    expect(find.text('Login'), findsOneWidget);

//----------------------do not proceed if the fields are empty------------------------------------//
   
    expect((tester.widget(usernameField) as TextField).controller?.text, '');
    expect((tester.widget(passwordField) as TextField).controller?.text, '');
    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Welcome'), findsNothing); //replace welcome with a keyword from the page that login button will load

//------------------proceed if all the fileds are filled----------------------------------------//
    await tester.enterText(usernameField, 'example_username');
    await tester.enterText(passwordField, 'example_password');

    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Welcome'), findsOneWidget); //replace welcome with a keyword from the page that login button will load
}

