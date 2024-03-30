import 'package:flutter/material.dart';
import 'recipedetail.dart';
import 'navigation.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.green,
         automaticallyImplyLeading: false,
        title: Navigationbar(),
      ),
      body: ListView(
        children: [
          _buildCuisineSection(context, 'Italian', [
            _buildRecipeCard(context, 'Spaghetti Carbonara',
                'A classic Italian pasta dish.'),
            _buildRecipeCard(context, 'Margherita Pizza',
                'Traditional pizza with tomatoes, mozzarella, and basil.'),
          ]),
          _buildCuisineSection(context, 'Mexican', [
            _buildRecipeCard(context, 'Tacos al Pastor',
                'Tacos filled with spit-grilled pork.'),
            _buildRecipeCard(
                context, 'Guacamole', 'Classic avocado-based dip.'),
          ]),
          // Add more cuisine sections as needed
        ],
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

  Widget _buildRecipeCard(
      BuildContext context, String title, String description) {
    return GestureDetector(
      onTap: () {
        // Navigate to recipe detail page when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipeDetailPage(title, description)),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Padding(
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
      ),
    );
  }
}
