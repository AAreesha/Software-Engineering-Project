import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mealkit/loginpage.dart';

void main() {
  testWidgets('Test Login Button Functionality', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Login()));

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Login Complete'), findsOneWidget);
  });

  testWidgets('Test Sign-Up Button Navigation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Login()));

    await tester.tap(find.text("Don't have an Account? Sign Up!"));
    await tester.pump();

    // You need to replace the below expect statement with the appropriate navigation check.
    expect(find.text('Sign Up Page'), findsOneWidget); // Change 'Sign Up Page' to the appropriate widget/page
  });

  testWidgets('Test Username and Password Text Fields', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Login()));

    await tester.enterText(find.byKey(Key('username_field')), 'testuser');
    await tester.enterText(find.byKey(Key('password_field')), 'testpassword');

    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('testpassword'), findsOneWidget);
  });

  testWidgets('Test Username and Password Text Fields Validation', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Login()));

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Please enter a username'), findsOneWidget);
    expect(find.text('Please enter a password'), findsOneWidget);
  });

  testWidgets('Test AppBar Title', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Login()));

    expect(find.text('Login Page'), findsOneWidget);
  });

  testWidgets('Test AppBar Center Alignment', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Login()));

    final appBar = find.byType(AppBar);
    final appBarWidget = tester.widget<AppBar>(appBar);

    expect(appBarWidget.centerTitle, true);
  });
}
