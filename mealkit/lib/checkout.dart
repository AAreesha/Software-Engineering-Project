import 'package:flutter/material.dart';
import 'package:mealkit/screens/services/database.dart';
import 'package:mealkit/navigation.dart';
import 'package:mealkit/models/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  late DatabaseService _databaseService;
  List<Map<String, dynamic>> _userOrders = [];
  List<Map<String, dynamic>> itemslist = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  bool? isCODSelected = false;
  late String _userEmail = '';

  @override
  void initState() {
    super.initState();
    _getUserEmail();
    final user = Provider.of<User_Details?>(context, listen: false);
    if (user == null || user.uid == null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/wrapper');
      });
    } else {
      _databaseService = DatabaseService(uid: user.uid!);
      _loadUserOrders();
    }
  }

  void _getUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.email != null) {
        setState(() {
          _userEmail = user.email!;
        });
      }
    } catch (e) {
      print('Error retrieving user email: $e');
    }
  }

  void _loadUserOrders() async {
    try {
      var orders = await _databaseService.getOrderDetails();
      setState(() {
        _userOrders = orders;
      });
    } catch (e) {
      debugPrint('Error loading orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = 0.0;
    double shipping = 150.0;
    double tax = 0.0;
    double total = 0.0;

    if (_userOrders.isNotEmpty) {
      subtotal = _userOrders
          .map((order) => order["price"] ?? 0.0)
          .reduce((value, element) => value + element);
      tax = 0.13 * subtotal;
      total = subtotal + shipping + tax;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form fields for user details and payment
                ],
              ),
            ),
            SizedBox(height: 20.0),
            if (_userOrders.isNotEmpty)
              Card(
                elevation: 4.0,
                margin: EdgeInsets.all(0.0),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Orders:',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: _userOrders.length,
                            itemBuilder: (context, index) {
                              var order = _userOrders[index];
                              var itemName = order["Name"] ?? 'Unknown Item';
                              var price = order["price"] != null ? '\Rs${order["price"].toStringAsFixed(2)}' : 'Unknown Price';
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      itemName,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Price: $price',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Order Summary',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12.0),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _OrderSummaryItem('Subtotal', '\Rs.${subtotal.toStringAsFixed(2)}'),
                                _OrderSummaryItem('Shipping', '\Rs.${shipping.toStringAsFixed(2)}'),
                                _OrderSummaryItem('Tax', '\Rs.${tax.toStringAsFixed(2)}'),
                                Divider(),
                                _OrderSummaryItem('Total', '\Rs.${total.toStringAsFixed(2)}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            if (_userOrders.isEmpty)
              Center(
                child: Text(
                  'Your cart is empty!',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  'Submit Order',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
