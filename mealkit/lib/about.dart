import 'package:flutter/material.dart';
import 'navigation.dart';
class CartItem {
  final String name;
  final double price;

  CartItem({required this.name, required this.price});
}
class AboutUsPage extends StatelessWidget {
  double total = 0.0;
  List<CartItem> cart = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Navigationbar(total: 0.0),
         automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome to Your Meal Kit Company!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Our Mission:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Our mission is to provide convenient, nutritious, and flavorful meal kits that inspire people to cook at home and enjoy the experience of preparing and sharing meals with their loved ones.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Why Choose Us?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Here at Your Meal Kit Company, we take pride in:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              _buildListItem('Using fresh, high-quality ingredients sourced from local farmers and suppliers.'),
              _buildListItem('Offering a wide variety of recipes to suit different tastes and dietary preferences, including vegetarian, vegan, and gluten-free options.'),
              _buildListItem('Providing step-by-step recipes and pre-portioned ingredients to make cooking hassle-free and enjoyable.'),
              _buildListItem('Ensuring sustainable practices in packaging and delivery to minimize our environmental footprint.'),
              _buildListItem('Offering flexible subscription plans that fit your lifestyle and schedule.'),
              _buildListItem('Delivering exceptional customer service and support.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}
