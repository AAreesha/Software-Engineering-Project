import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mealkit/screens/services/auth.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'registration.dart';
import 'menupage.dart'; 
import 'loginpage.dart';
import 'voucher.dart';
import 'package:mealkit/screens/authenticate/register.dart';
import 'package:mealkit/screens/authenticate/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:mealkit/models/user.dart';
import 'package:mealkit/screens/wrapper.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAwIaft9z3H84LD2T_gjHJTR-nxU_67U-U", 
      appId: "1:401710519943:web:6fb9a9e8194470b24bca22", 
      messagingSenderId: "401710519943", 
      projectId: "mealkit-project")
  );
  // Initialize databaseFactory before using sqflite functions
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); // Fix the constructor definition

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      //  home: MenuPage(),
      home: HomeView(),
      routes: {
    '/menu': (context) => MenuPage(),
    '/home': (context) => HomeView(),
    '/voucher': (context) => VoucherPage(),
    '/wrapper': (context) => Wrapper(),
    // Define routes for other pages if needed
  },
    );
  }
}
