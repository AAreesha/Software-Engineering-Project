import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mealkit/screens/services/database.dart';
import 'package:mealkit/screens/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:mealkit/models/user.dart';
import 'menupage.dart';


class Navigationbar extends StatefulWidget {
  final double total;

  const Navigationbar({Key? key, required this.total}) : super(key: key);

  @override
  _NavigationbarState createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {

  @override
  

  List<Map<String, dynamic>> itemslist = []; // List to hold orders data
  String searchQuery = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  late DatabaseService _databaseService; // Instance of DatabaseService
  void initState() {
  super.initState();

  // Get the current user from the Provider
  final user = Provider.of<User_Details?>(context, listen: false);

  // Check if the user is not logged in or user ID is null
  if (user == null || user.uid == null) {
  } else {
    _databaseService = DatabaseService(uid: user.uid!); // Initialize with userId
  }
}
void cartitems() async {

    // Now add to Firestore
     try {
      var orders = await _databaseService.getOrderDetails();
      setState(() {
        itemslist = orders;
      });
      print('Items retrieved from Firestore: $itemslist');
    } catch (e) {
      debugPrint('Error loading orders: $e'); // Error handling
    }

  }


  Widget build(BuildContext context) {
    cartitems();
    // Check if there are items in the cart
    bool hasItems = itemslist.isNotEmpty;
    // Calculate the number of items in the cart
    int itemCount = itemslist.length;

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
          _NavBarItem('About Us', '/about'),
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
                    CartPanel.showCartPanel(context, itemslist).then((value) {
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
                CartPanel.showCartPanel(context, itemslist).then((value) {
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
  final List<Map<String, dynamic>> items;

  CartPanel({required this.items});
  static Future<void> showCartPanel(BuildContext context, List<Map<String, dynamic>> items) async {
    double shipping = 150.0;
   double total = items.fold(0.0, (previousValue, items) => previousValue + items['price']);
    double tax = total * 0.13;
    double totalBill = total + shipping + tax;
    final AuthService _auth = AuthService();
    final _formKey = GlobalKey<FormState>();
    late DatabaseService _databaseService; // Instance of DatabaseService
    final user = Provider.of<User_Details?>(context, listen: false);
    if (user == null || user.uid == null) {
  } else {
    _databaseService = DatabaseService(uid: user.uid!); // Initialize with userId
  }


    void removeitem(String name, double price, Timestamp timestamp, String userid ) async {

    // Now add to Firestore
     try {
      await _databaseService.deleteOrderItem(userid, name, price);
    print('Order deleted successfully');
    } catch (e) {
    print('Error deleting order: $e');
    throw e; // Re-throw the error for handling at a higher level if needed
  }

  }

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
                                          Text(items[index]['Name']),
                                          IconButton(
                                            onPressed: () {
                                              // Remove the item from the cart
                                              // You may want to add a confirmation dialog here
                                              setState(() {
                                                removeitem(items[index]['Name'],items[index]['price'],items[index]['timestamp'],items[index]['userId']);
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
                                      trailing: Text('\Rs.${items[index]['price'].toStringAsFixed(2)}'),
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
                                // Navigate to the checkout page and pass parameters
                                Navigator.pushNamed(
                                  context, 
                                  '/checkout', 
                                );
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
