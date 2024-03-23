import 'package:flutter/material.dart';

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
          _NavBarItem('Menu'),
          SizedBox(width: 100), // Add space between Menu and Voucher
          _NavBarItem('Voucher'),
          SizedBox(width: 100), // Add space between Voucher and About Us
          _NavBarItem('About Us'),
          Spacer(), // Take all available space between About Us and right corner
          _NavBarItem('Login'),
          SizedBox(width: 20), // Add space between Login and Cart
          _CartButton(),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  const _NavBarItem(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize:20 , color: Colors.white),
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
