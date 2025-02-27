import 'package:flutter/material.dart';
import 'navigation.dart'; // Import the Navigationbar widget file here
import 'package:mealkit/screens/services/auth.dart';
import 'package:mealkit/screens/services/database.dart';
import 'package:provider/provider.dart';
import 'package:mealkit/models/user.dart';
const kPrimaryColor = Color.fromARGB(255, 0, 0, 0);
const kSecondaryColor = Color.fromARGB(255, 47, 112, 50); // Dark green color
const kMaxWidth = 1232.0;
const kPadding = 20.0;

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  double total = 0.0;
  String searchQuery = '';
  final AuthService _auth = AuthService();
  void addToCart(String itemName, double price) async {

    // Now add to Firestore
    try {
      await _auth.addOrderDetails(itemName, price); // Call AuthService's addOrderDetails
    } catch (e) {
      print('Error adding to Firestore: $e');
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        automaticallyImplyLeading: false,
        title: Navigationbar(
          total: total,

          
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(kPadding),
            child: _buildSearchBar(context, (query) {
              setState(() {
                searchQuery = query; // Update the search query
              });
            }),
          ),
Padding(
  padding: EdgeInsets.all(kPadding),
  child: _buildCuisineSection(context, 'Korean', [
    _buildRecipeButton(
      context,
      'Kimchi Stew',
      'Spicy Korean Kimchi Stew',
      'assets/stew.png',
      1500.99,
    ),
    _buildRecipeButton(
      context,
      'Bibimbap',
      'Traditional Korean rice dish',
      'assets/bibimbap.png', // Correct the image path if needed
      2500.99,
    ),
    _buildRecipeButton(
      context,
      'Beef Ramen',
      'Japanese-style ramen noodles',
      'assets/ramen.png',
      1500.99,
    ),
    _buildRecipeButton(
      context,
      'Spicy Ribs',
      'Tender Korean-style beef ribs',
      'assets/ribs.png',
      2500.99,
    ),
    _buildRecipeButton(
      context,
      'Fishcake Soup',
      'Traditional Korean soup',
      'assets/fishcake.png',
      2500.99,
    ),
    _buildRecipeButton(
      context,
      'Black Noodles',
      'Korean-Chinese noodle.',
      'assets/black.png',
      2500.99,
    ),
  ]),
),

Padding(
  padding: EdgeInsets.all(kPadding),
  child: _buildCuisineSection(context, 'Indian', [
    _buildRecipeButton(
      context,
      'Butter Chicken',
      'Indian dish with cashews',
      'assets/experiment.png',
      2700.99,
    ),
    _buildRecipeButton(
      context,
      'Khoya Kulfi',
      'Traditional Indian dessert.',
      'assets/kulfi.png',
      3000.99,
    ),
    _buildRecipeButton(
      context,
      'Cholay Tarka',
      'Spicy and tangy chickpea curry',
      'assets/chola (1).png',
      3000.99,
    ),
    _buildRecipeButton(
      context,
      'Kadhi Chawal',
      'Creamy yogurt-based curry',
      'curry.png',
      3000.99,
    ),
    _buildRecipeButton(
      context,
      'Mutton Stew',
      'Slow-cooked mutton stew ',
      'stew.png',
      3000.99,
    ),
        _buildRecipeButton(
      context,
      'Ras Malai',
      'Milky Dessert with Saffron',
      'ras.png',
      3000.99,
    ),
  ]),
),

Padding(
  padding: EdgeInsets.all(kPadding),
  child: _buildCuisineSection(context, 'Italian', [
    _buildRecipeButton(
      context,
      'Chicken Parm',
      'Golden Crusted Fillet',
      'assets/parm.png',
      2700.99,
    ),
    _buildRecipeButton(
      context,
      'Spaghetti',
      'Meatball Sauce',
      'assets/spag.png',
      3000.99,
    ),
    _buildRecipeButton(
      context,
      'Tiramisu',
      'Cocoa Cream',
      'assets/tir.png',
      3000.99,
    ),
    _buildRecipeButton(
      context,
      'Seafood Pasta',
      'Mussels and Clams',
      'sea.png',
      3000.99,
    ),
    _buildRecipeButton(
      context,
      'Lasagna',
      'Beef and Cheese ',
      'las.png',
      3000.99,
    ),
        _buildRecipeButton(
      context,
      'Pesto Pasta',
      'Vegan Herb Pasta ',
      'bestseller1.png',
      3000.99,
    ),
  ]),
),

          // Add more cuisine sections as needed
        ],
      ),
    );
  }

 Widget _buildSearchBar(BuildContext context, Function(String) onSearchChanged) {
    return Container(
      height: 40, // Adjust the height of the container
      width: 200, // Adjust the width of the container
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: TextFormField(
        onChanged: (value) {
          onSearchChanged(value); // Pass the search query to the parent widget
        },
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildCuisineSection(
      BuildContext context, String title, List<Widget> recipes ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: recipes,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRecipeButton(
      BuildContext context, String title, String description, String imagePath, double price) {
    return ElevatedButton(
      onPressed: () {
        // Show a dialog when the button is pressed
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    description,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add to Cart functionality
                      final user = Provider.of<User_Details?>(context, listen: false);
                      if (user == null || user.uid == null) {
                          // Navigate to login page
                          WidgetsBinding.instance?.addPostFrameCallback((_) {
                            Navigator.pushReplacementNamed(context, '/wrapper'); // '/wrapper' represents your login page route
                          });}
                      else {
                      addToCart(title, price);
                      print('$title added to cart');
                      Navigator.of(context).pop(); // Close the dialog
          }},
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero, // No padding
      ),
      child: Container(
        width: 200, // Set the width of the card here
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: kSecondaryColor, // Set the background color here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\Rs.$price', // Displaying price
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


