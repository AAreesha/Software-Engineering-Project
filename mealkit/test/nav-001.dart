import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart'; // Import Mockito
import 'package:mealkit/navigation.dart'; // Import your navigation bar file
import 'package:cloud_firestore/cloud_firestore.dart'; // Import FirebaseFirestore
import 'package:mealkit/screens/services/auth.dart'; // Import AuthService
import 'package:provider/provider.dart'; // Import Provider for dependency injection

// Mock Firestore
class MockFirestore extends Mock implements FirebaseFirestore {}

// Mock AuthService
class MockAuthService extends Mock implements AuthService {}

void testnav(WidgetTester tester, MockFirestore mockFirestore, MockAuthService mockAuthService) async{
  // Instantiate mocks
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(
          providers: [
            Provider<FirebaseFirestore>.value(
              value: mockFirestore,
            ),
            Provider<AuthService>.value(
              value: mockAuthService,
            ),
          ],
          child: Scaffold(
            body: Navigationbar(total: 0.0), // Render the navigation bar in a scaffold
          ),
        ),
      ),
    );

    // Verify that the navigation bar is displayed properly
    expect(find.byType(Navigationbar), findsOneWidget);

    // Test navigation as before
    // For example:
    // Tap on the 'Home' item and verify navigation
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('Home Page'), findsOneWidget); // Assuming 'Home Page' is displayed after navigating to '/home'

    // Add similar tests for other navigation bar items
    // For example:
    // Tap on the 'Menu' item and verify navigation
    await tester.tap(find.text('Menu'));
    await tester.pumpAndSettle();
    expect(find.text('Menu Page'), findsOneWidget); // Assuming 'Menu Page' is displayed after navigating to '/menu'

    // Continue adding test cases for other navigation bar items
 
}
