import 'package:flutter/material.dart';
import 'navigation.dart'; // Import the Navigationbar widget file here

class CartItem {
  final String name;
  final double price;

  CartItem({required this.name, required this.price});
}
const kPrimaryColor = Color(0xFFe1eaf1);
const kSecondaryColor = Colors.green; // Dark green color
const kMaxWidth = 1232.0;
const kPadding = 20.0;

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  double total = 0.0;
  List<CartItem> cart = [];
  String SearchQuery = '';

  void addToCart(String itemName, double price) {
    setState(() {
      cart.add(CartItem(name: itemName, price: price));
      total += price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        automaticallyImplyLeading: false,
        title: Navigationbar(
          total: total,
          cartItems: cart,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(kPadding),
            child: _buildSearchBar(context, (query) {
              setState(() {
                SearchQuery = query; // Update the search query
              });
            }),
          ),
          Padding(
            padding: EdgeInsets.all(kPadding),
            child: _buildCuisineSection(context, 'Italian', [
              _buildRecipeButton(context, 'Carbonara Pasta',
                  'Creamy Italian pasta dish with pancetta, and black pepper.', 'assets/bestseller1.png', 1500.99),
              _buildRecipeButton(context, 'Margherita Pizza',
                  'Traditional pizza with tomatoes, mozzarella, and basil.', 'assets/bestseller1.png', 2500.99),
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(kPadding),
            child: _buildCuisineSection(context, 'Mexican', [
              _buildRecipeButton(context, 'Tacos al Pastor',
                  'Tacos filled with spit-grilled pork.', 'assets/bestseller1.png', 2700.99),
              _buildRecipeButton(context, 'Guacamole',
                  'Classic avocado-based dip.', 'assets/bestseller1.png', 3000.99),
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
                      addToCart(title, price);
                      print('$title added to cart');
                      Navigator.of(context).pop(); // Close the dialog
                    },
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


