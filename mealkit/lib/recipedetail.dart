import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final String title;
  final String description;

  RecipeDetailPage(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
         automaticallyImplyLeading: false,
      ),
      body: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: 'Ingredients'),
                Tab(text: 'Instructions'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // First Tab: Ingredients
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ingredients for $title',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'List of ingredients goes here...',
                        style: TextStyle(fontSize: 16),
                      ),
                      // You can replace the above text with actual ingredients
                    ],
                  ),
                ),
              ),

              // Second Tab: Instructions
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Instructions for $title',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Recipe instructions go here...',
                        style: TextStyle(fontSize: 16),
                      ),
                      // You can replace the above text with actual recipe instructions
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
