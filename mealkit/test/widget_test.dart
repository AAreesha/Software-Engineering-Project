import 'package:flutter_test/flutter_test.dart';
import 'hometests.dart';
import 'loginpagetests.dart';
import 'registrationpagetest.dart';
//include cartpage, loginpage

void main() 
{
    testWidgets('HomePage Test', (WidgetTester tester) async
    {
        testHomeUI(tester);
        // testCartButton(tester);
        // testLoginButton(tester);
        //add testers for other button on the navigation bar
    });  

    // testWidgets('LoginPage Test', (WidgetTester tester) async
    // {
    //     testLogin(tester);
    // });  

    // testWidgets('RegistrationPage Test', (WidgetTester tester) async
    // {
    //     testregistration(tester);
    // });  
}


