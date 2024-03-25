import 'package:flutter/material.dart';
import 'home.dart';
import 'registration.dart';
import 'menupage.dart'; 
import 'loginpage.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  // Initialize databaseFactory before using sqflite functions
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      // home: HomeView(),
      home: Registration()
      // home: MenuPage(),
      // home: Login()
    );
  }
}

