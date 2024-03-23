import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//include registrationpage

void testregistration(WidgetTester tester) async {

//------------------build a sample page------------------------------------------------------------//
   await tester.pumpWidget(MaterialApp(
      // home: HomeView(), //replace with registration page
    ));

//------------------store all the UI elements-----------------------------------------------------//
//replace labels
    Finder usernameField = find.byKey(Key('username_field'));
    Finder passwordField = find.byKey(Key('password_field'));
    Finder emailField = find.byKey(Key('email_field'));
    Finder nameField = find.byKey(Key('name_field'));
    Finder contactField = find.byKey(Key('contact_field'));
    Finder addressField = find.byKey(Key('address_field'));
    Finder registrationButton = find.byKey(Key('registration_button'));

//---------------------verify the UI----------------------------------------------------------------//
    expect(usernameField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(emailField, findsOneWidget);
    expect(nameField, findsOneWidget);
    expect(contactField, findsOneWidget);
    expect(addressField, findsOneWidget);
    expect(registrationButton, findsOneWidget);

    expect(usernameField, isInstanceOf<TextField>());
    expect(passwordField, isInstanceOf<TextField>());
    expect(emailField, isInstanceOf<TextField>());
    expect(nameField, isInstanceOf<TextField>());
    expect(contactField, isInstanceOf<TextField>());
    expect(addressField, isInstanceOf<TextField>());
    expect(registrationButton, isInstanceOf<ElevatedButton>());
//replace registration
    expect(find.text('registration'), findsOneWidget);
//--------------------------donot proceed until fields are filled-------------------------------------//

    expect((tester.widget(usernameField) as TextField).controller?.text, '');
    expect((tester.widget(passwordField) as TextField).controller?.text, '');
    expect((tester.widget(emailField) as TextField).controller?.text, '');
    expect((tester.widget(contactField) as TextField).controller?.text, '');
    expect((tester.widget(nameField) as TextField).controller?.text, '');
    expect((tester.widget(addressField) as TextField).controller?.text, '');

    await tester.tap(registrationButton);
    await tester.pump();

    expect(find.text('Welcome'), findsNothing); //replace welcome with a keyword from the page that registration button will load


//------------------------proceed if all the fields are filled-----------------------------------------//
    await tester.enterText(usernameField, 'example_username');
    await tester.enterText(passwordField, 'example_password');
    await tester.enterText(contactField, 'example_contact');
    await tester.enterText(nameField, 'example_name');
    await tester.enterText(addressField, 'example_address');
    await tester.enterText(emailField, 'example_email');

    await tester.tap(registrationButton);
    await tester.pump();

    expect(find.text('Welcome'), findsOneWidget); //replace welcome with a keyword from the page that registration button will load
}

