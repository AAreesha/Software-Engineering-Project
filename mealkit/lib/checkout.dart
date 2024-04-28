import 'package:flutter/material.dart';
import 'package:mealkit/screens/services/database.dart';
import 'package:mealkit/navigation.dart';
import 'package:mealkit/models/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckoutPage extends StatefulWidget {
  // No need for userId as a parameter
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  late DatabaseService _databaseService; // Instance of DatabaseService
  List<Map<String, dynamic>> _userOrders = []; // List to hold orders data
   List<Map<String, dynamic>> itemslist = []; // List to hold orders data

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  bool? isCODSelected = false;
 
  late String _userEmail = ''; // Variable to hold user's email
 

  @override
  void initState() {
  super.initState();
  _getUserEmail(); // Call function to retrieve user's email
  


  // Get the current user from the Provider
  final user = Provider.of<User_Details?>(context, listen: false);

  // Check if the user is not logged in or user ID is null
  if (user == null || user.uid == null) {
    // Navigate to login page
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/wrapper'); // '/wrapper' represents your login page route
    });
  } else {
    _databaseService = DatabaseService(uid: user.uid!); // Initialize with userId
    _loadUserOrders(); // Load orders
  }
}

//changes
void _getUserEmail() async {
  try {
    // Get current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      setState(() {
        _userEmail = user.email!; // Update user's email in the state
      });
    }
  } catch (e) {
    print('Error retrieving user email: $e');
  }
}

void _loadUserOrders() async {
    try {
      var orders = await _databaseService.getUserOrders();
      setState(() {
        _userOrders = orders;
      });
    } catch (e) {
      debugPrint('Error loading orders: $e'); // Error handling
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout '),
        // automaticallyImplyLeading: false,
        // backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Form Section
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form fields for user details and payment
                  // Existing code
                ],
              ),
            ),

            // Orders Section
            SizedBox(height: 20.0),
            Text(
              'Your Orders:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            _userOrders.isEmpty
                ? Text('No orders found.') // No orders message
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _userOrders.length,
                    itemBuilder: (context, index) {
                      var order = _userOrders[index];
                      var userId = order["userId"] ?? 'Unknown'; // Null check
                      var itemName = order["Name"] ?? 'Unknown Item'; // Null check
                      var price = order["price"] != null ? '\$${order["price"]}' : 'Unknown Price'; // Null check
                     

                      return ListTile(
                        title: Text('Order ID: $userId'),
                        subtitle: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Item: $itemName - Price: $price'),
                                  Text('Item: $itemName - Price: $price'),
                                  Text('UserID: $itemName - $userId')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: 20),
                                    Text('Subtotal: \Rs.0'),
                                    Text('Shipping: \Rs.0'),
                                    Text('Tax: \Rs.0'),
                                    Divider(),
                                    Text('Total: \Rs.0'),
                                    SizedBox(height: 20),
                                  ]
                                ),
                              ),
                            ),
                          ],
                        ),
                      );

                    },
                  ),
                  
          ],
        ),
      ),
    );
  }
}
