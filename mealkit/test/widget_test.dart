import 'package:flutter_test/flutter_test.dart';
import 'hometests.dart';
import 'loginpagetests.dart';
//include cartpage, loginpage

void main() 
{
    testWidgets('HomePage Test', (WidgetTester tester) async
    {
      //main page
        testHomeUI(tester);
        testCartButton(tester);
        testLoginButton(tester);
        //add testers for other button on the navigation bar
    });  


    testWidgets('LoginPage Test', (WidgetTester tester) async
    {
        testLoginUI(tester);
        testInputnotEmptyLogin(tester); 
    });  
}


