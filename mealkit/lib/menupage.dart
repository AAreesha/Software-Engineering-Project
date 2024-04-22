import 'package:flutter/material.dart';
import 'navigation.dart'; // Import the Navigationbar widget file here

const kPrimaryColor = Color(0xFFe1eaf1);
const kSecondaryColor = Colors.green; // Dark green color
const kMaxWidth = 1232.0;
const kPadding = 20.0;

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        automaticallyImplyLeading: false,
        title: Navigationbar(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(kPadding),
            child: _buildSearchBar(context),
          ),
          Padding(
            padding: EdgeInsets.all(kPadding),
            child: _buildCuisineSection(context, 'Italian', [
              _buildRecipeButton(context, 'Carbonara Pasta',
                  'Creamy Italian pasta dish with pancetta, and black pepper.', 'assets/bestseller1.png'),
              _buildRecipeButton(context, 'Margherita Pizza',
                  'Traditional pizza with tomatoes, mozzarella, and basil.', 'assets/bestseller1.png'),
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(kPadding),
            child: _buildCuisineSection(context, 'Mexican', [
              _buildRecipeButton(context, 'Tacos al Pastor',
                  'Tacos filled with spit-grilled pork.', 'assets/bestseller1.png'),
              _buildRecipeButton(context, 'Guacamole',
                  'Classic avocado-based dip.', 'assets/bestseller1.png'),
            ]),
          ),
          // Add more cuisine sections as needed
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 40, // Adjust the height of the container
      width: 200, // Adjust the width of the container
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildCuisineSection(
      BuildContext context, String title, List<Widget> recipes) {
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
      BuildContext context, String title, String description, String imagePath) {
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
                      // Implement Add to Cart functionality here
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

