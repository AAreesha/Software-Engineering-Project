import 'package:flutter_test/flutter_test.dart';
import 'hometests.dart';
//include cartpage, loginpage

void main() 
{
    testWidgets('HomePage Test', (WidgetTester tester) async
    {
        testHomeUI(tester);
        // testCartButton(tester);
        // testLoginButton(tester);
        //add other buttons as needed
    });  
}


