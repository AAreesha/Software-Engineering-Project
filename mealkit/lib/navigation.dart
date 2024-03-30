import 'package:flutter/material.dart';
import 'Menupage.dart'; // Import your MenuPage.dart file here

class Navigationbar extends StatelessWidget {
  const Navigationbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 80,
            width: 150,
            child: Image.asset('assets/logo.png'), // Replace 'assets/logo.png' with your logo path
          ),
          SizedBox(width: 100), // Add space between logo and menu items
          _NavBarItem('Home', '/home'),
          SizedBox(width: 100), // Add space between logo and menu items
          _NavBarItem('Menu', '/menu'),
          SizedBox(width: 100), // Add space between Menu and Voucher
          _NavBarItem('Voucher', '/voucher'),
          SizedBox(width: 100), // Add space between Voucher and About Us
          _NavBarItem('About Us', '/menu'),
          Spacer(), // Take all available space between About Us and right corner
          _NavBarItem('Login', '/wrapper'),
          SizedBox(width: 20), // Add space between Login and Cart
          _CartButton(),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final String route;

  const _NavBarItem(
    this.title,
    this.route, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconButton(
          onPressed: () {
            // Handle cart button press
          },
          icon: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
        ),
      ],
    );
  }
}

