import 'package:flutter/material.dart';
import 'navigation.dart'; // Import the Navigationbar widget file here

const kPrimaryColor = Color(0xFFe1eaf1);
const kSecondaryColor = Color(0xFF006400); // Dark green color
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
              _buildRecipeCard(context, 'Carbonara Pasta',
                  'Creamy Italian pasta dish with pancetta, and black pepper.', 'assets/bestseller1.png'),
              _buildRecipeCard(context, 'Margherita Pizza',
                  'Traditional pizza with tomatoes, mozzarella, and basil.', 'assets/bestseller1.png'),
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(kPadding),
            child: _buildCuisineSection(context, 'Mexican', [
              _buildRecipeCard(context, 'Tacos al Pastor',
                  'Tacos filled with spit-grilled pork.', 'assets/bestseller1.png'),
              _buildRecipeCard(context, 'Guacamole',
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

Widget _buildRecipeCard(
    BuildContext context, String title, String description, String imagePath) {
  return GestureDetector(
    onTap: () {
      // Navigate to recipe detail page when tapped
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => RecipeDetailPage(title, description)),
      // );
    },
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




// class MenuPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         automaticallyImplyLeading: false,
//         title: Navigationbar(),
//       ),
//       body: ListView(
//         children: [

// padding: EdgeInsets.all(kPadding),
          // _buildCuisineSection(context, 'Italian', [
          //   _buildRecipeCard(context, 'Spaghetti Carbonara',
          //       'A classic Italian pasta dish.'),
          //   _buildRecipeCard(context, 'Margherita Pizza',
          //       'Traditional pizza with tomatoes, mozzarella, and basil.'),
          // ]),
          // _buildCuisineSection(context, 'Mexican', [
          //   _buildRecipeCard(context, 'Tacos al Pastor',
          //       'Tacos filled with spit-grilled pork.'),
          //   _buildRecipeCard(
          //       context, 'Guacamole', 'Classic avocado-based dip.'),
  //         ]),
  //         // Add more cuisine sections as needed
  //       ],
  //     ),
  //   );
  // }

//   Widget _buildCuisineSection(
//       BuildContext context, String title, List<Widget> recipes) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             title,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//         ),
//         SizedBox(height: 8),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: recipes,
//           ),
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget _buildRecipeCard(
//       BuildContext context, String title, String description) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to recipe detail page when tapped
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => RecipeDetailPage(title, description)),
//         );
//       },
//       child: Card(
//         margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 description,
//                 style: TextStyle(fontSize: 14),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
