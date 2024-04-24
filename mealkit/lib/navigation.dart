import 'package:flutter/material.dart';
import 'menupage.dart';


class Navigationbar extends StatelessWidget {
  final double total;
  final List<CartItem> cartItems;

  const Navigationbar({Key? key, required this.total, required this.cartItems}) : super(key: key);

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
          _CartButton(total: total, cartItems: cartItems), // Added Cart Button here
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
  final double total;
  final List<CartItem> cartItems;

  const _CartButton({Key? key, required this.total, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Open the cart panel
        CartPanel.showCartPanel(context, total, cartItems);
      },
      icon: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
    );
  }
}

class CartPanel extends StatelessWidget {
  static showCartPanel(BuildContext context, double total, List<CartItem> items) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        double shipping = 150;
        double tax = total * 0.13;
        double totalBill = total + shipping + tax;

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
                      '(${items.length} items)',
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
                      child: items.isEmpty
                          ? Center(child: Text("No items in your cart"))
                          : ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(items[index].name),
                                      IconButton(
                                        onPressed: () {
                                          // Remove the item from the cart
                                          // You may want to add a confirmation dialog here
                                          items.removeAt(index);
                                          // Update the total
                                          total = items.fold(0, (previousValue, element) => previousValue + element.price);
                                          // Rebuild the cart panel
                                          Navigator.pop(context);
                                          CartPanel.showCartPanel(context, total, items);
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ],
                                  ),
                                  trailing: Text('\Rs.${items[index].price.toStringAsFixed(2)}'),
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
                          _OrderSummaryItem('Subtotal', '\Rs.${total.toStringAsFixed(2)}'),
                          _OrderSummaryItem('Shipping', '\Rs.${shipping.toStringAsFixed(2)}'),
                          _OrderSummaryItem('Tax', '\Rs.${tax.toStringAsFixed(2)}'),
                          Divider(),
                          _OrderSummaryItem('Total', '\Rs.${totalBill.toStringAsFixed(2)}'),
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
