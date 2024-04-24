import 'package:flutter/material.dart';
import 'menupage.dart';

class Navigationbar extends StatefulWidget {
  final List<CartItem> cartItems;
  final double total;

  const Navigationbar({Key? key, required this.cartItems, required this.total}) : super(key: key);

  @override
  _NavigationbarState createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
  @override
  Widget build(BuildContext context) {
    // Check if there are items in the cart
    bool hasItems = widget.cartItems.isNotEmpty;
    // Calculate the number of items in the cart
    int itemCount = widget.cartItems.length;

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
          // Display cart icon only if there are items in the cart
          if (hasItems)
            Stack(
              children: [
                IconButton(
                  onPressed: () {
                    // Open the cart panel
                    CartPanel.showCartPanel(context, widget.cartItems).then((value) {
                      // Update the state of Navigationbar when the CartPanel is closed
                      setState(() {});
                    });
                  },
                  icon: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
                ),
                // Display the number of items on the top of the cart icon
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      itemCount.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            // Display cart icon only if there are items in the cart
            IconButton(
              onPressed: () {
                // Open the cart panel
                CartPanel.showCartPanel(context, widget.cartItems).then((value) {
                  // Update the state of Navigationbar when the CartPanel is closed
                  setState(() {});
                });
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
            ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final String route;

  const _NavBarItem(this.title, this.route, {Key? key}) : super(key: key);

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

class CartPanel extends StatelessWidget {
  static Future<void> showCartPanel(BuildContext context, List<CartItem> items) async {
    double shipping = 0.0;
    double total = items.fold(0, (previousValue, element) => previousValue + element.price);
    double tax = total * 0.13;
    double totalBill = total + shipping + tax;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                                              setState(() {
                                                items.removeAt(index);
                                              });

                                              // Rebuild the CartPanel with the updated items
                                              setState(() {});

                                              // Rebuild the Navigationbar with the updated itemCount
                                              Navigator.pop(context);
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

  const _OrderSummaryItem(this.label, this.value, {Key? key}) : super(key: key);

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
