import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'loginpage_test.dart';
import 'nav-001.dart';
import 'home_testui.dart'; // Import your navigation bar file
import 'package:firebase_core/firebase_core.dart';
// Mock Firestore



void main() 
{
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized(); 
      await Firebase.initializeApp();
    });

  late MockFirestore mockFirestore;
  late MockAuthService mockAuthService;

  setUp(() {
    mockFirestore = MockFirestore();
    mockAuthService = MockAuthService();
  });


   testWidgets('NAV-001 Test', (WidgetTester tester) async
    {
        testnav(tester, mockFirestore, mockAuthService);
    });  

    testWidgets('Home UI Test', (WidgetTester tester) async
    {
        testAboutUsButton(tester);
        testCartButton(tester);
        testHomeUI(tester);
        testLoginButton(tester);
        testMenuButton(tester);
        testVoucherButton(tester);
    });  

    testWidgets('Login Test', (WidgetTester tester) async
    {
        testLogin(tester);
    }); 

}


