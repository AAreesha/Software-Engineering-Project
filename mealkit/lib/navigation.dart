import 'package:flutter/material.dart';
import 'Menupage.dart'; // Import your MenuPage.dart file here
import 'review.dart'; // Import your review.dart file here

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
          _CartButton(), // Added Cart Button here
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
    return IconButton(
      onPressed: () {
        // Open the cart panel
        CartPanel.showCartPanel(context,5);
      },
      icon: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
    );
  }
}

class CartPanel extends StatelessWidget {
  static showCartPanel(BuildContext context, int totalItems) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.pink[50],
                child: Row(
                  children: [
                    Text(
                      'Basket ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '($totalItems items)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Add space between basket and order summary
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        itemCount: totalItems,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Item ${index + 1}'),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 20), // Add space between items and order summary
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Summary',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          _OrderSummaryItem('Subtotal', '\$100.00'),
                          _OrderSummaryItem('Shipping', '\$10.00'),
                          _OrderSummaryItem('Tax', '\$5.00'),
                          Divider(),
                          _OrderSummaryItem('Total', '\$115.00'),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/menu');
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            ),
                            child: Text(
                              'Continue to Payment',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class _OrderSummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _OrderSummaryItem(
    this.label,
    this.value, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }
}
