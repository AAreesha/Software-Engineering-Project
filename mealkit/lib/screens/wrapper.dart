import 'package:mealkit/models/user.dart';
import 'package:mealkit/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mealkit/models/user.dart';
import 'package:mealkit/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User_Details?>(context);
    // return either the Home or Authenticate widget
    if(user == null)
    {return Authenticate();}
    else
    {
      return HomeView();
    }
    
    
  }
}