import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'navigation.dart';
import 'review.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mealkit/screens/wrapper.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  return Container(
    color: Color(0xFFFFF2DE),
    
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: Navigationbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            _buildCarousel(), // Carousel section
            SizedBox(height: 20),
            _buildBestSellersSection(), // Best sellers section
            SizedBox(height: 20),
            _buildAdditionalSection(), // Additional section
           SizedBox(height: 20),
              _buildCarouselWithButton(context),
            SizedBox(height: 20),
            _buildGreenBackgroundContent(), // Content with green background
          ],
        ),
      ),
    ),
  );
}


  Widget _buildCarouselWithButton(BuildContext context) {
  // Define button text and icon
  String buttonText = 'Get Started';
  IconData buttonIcon = Icons.arrow_forward;

  return Container(
    color: Color(0xFFD29114),
    padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 100.0), // Add space between button and carousel
          child: ElevatedButton.icon(
            onPressed: () {
              // Navigate to login page when button is pressed
              Navigator.pushNamed(context,'/wrapper'
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Green button color
            ),
            icon: Icon(buttonIcon),
            label: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white, // White text color
              ),
            ),
          ),
        ),
        Expanded(
          child: _buildBottomCarousel(), // Your existing carousel widget
        ),
      ],
    ),
  );
}



Widget _buildBottomCarousel() {
  double carouselHeight = 200; 
  double aspectRatio = 16 / 9;
  double maxWidth = carouselHeight * aspectRatio;

  final CarouselController _controller = CarouselController();

  List<CarouselItem> carouselItems = [
    CarouselItem(
      imagePath: 'assets/review1.png',
      text: 'Great food, excellent service!',
    ),
    CarouselItem(
      imagePath: 'assets/review2.png',
      text: 'Amazing experience, will definitely order again!',
    ),
    CarouselItem(
      imagePath: 'assets/review3.png',
      text: 'Delicious and healthy food option',
    ),
    
  ];

  return Column(
    children: [
      CarouselSlider(
  carouselController: _controller,
  options: CarouselOptions(
    height: carouselHeight,
    enlargeCenterPage: true,
    autoPlay: false,
    aspectRatio: aspectRatio,
    autoPlayCurve: Curves.fastOutSlowIn,
    enableInfiniteScroll: false,
    autoPlayAnimationDuration: Duration(milliseconds: 800),
    viewportFraction: 0.9,
  ),
  items: carouselItems.map((item) {
    return Builder(
      builder: (BuildContext context) {
        return SizedBox(
          height: carouselHeight,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: maxWidth,
                  child: Image.asset(
                    item.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                item.text,
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
                maxLines: 2, // Adjust max lines as needed
              ),
            ],
          ),
        );
      },
    );
  }).toList(),
),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _controller.previousPage();
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              _controller.nextPage();
            },
          ),
        ],
      ),
    ],
  );
}

  Widget _buildCarousel() {
    double carouselHeight = 200; 
    double aspectRatio = 16 / 9;
    double maxWidth = carouselHeight * aspectRatio;

    final CarouselController _controller = CarouselController();

    return CarouselSlider(
      carouselController: _controller,
      options: CarouselOptions(
        height: carouselHeight,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: aspectRatio,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.9,
      ),
      items: [
        'assets/image1.jpg',
        'assets/image2.jpg',
        'assets/image5.jpg',
        'assets/image3.jpg',
        'assets/image4.jpg',
        'assets/image6.jpg',
      ].map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: maxWidth,
              height: carouselHeight,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.asset(
                item,
                fit: BoxFit.contain,
              ),
            );
          },
        );
      }).toList(),
    );
  }

 Widget _buildAdditionalSection() {
  return Container(
    color: Colors.lightGreen, // Set light green background color
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildImageWithText('assets/cook.png', 'Meal Kits that fit your needs'),
            _buildImageWithText('assets/note.png', 'Customize your own meals'),
            _buildImageWithText('assets/spoon.png', 'Fresh,pre-portioned ingredients'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildImageWithText(String imagePath, String text) {
  return Column(
    children: [
      Image.asset(
        imagePath,
        width: 100,
        height: 100,
      ),
      SizedBox(height: 4),
      Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ),
      ),
    ],
  );
}


  

Widget _buildBestSellersSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'Best Sellers',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _buildBestSellerItem('assets/bestseller1.png', 'Product 1', 200, 200), // Adjust dimensions as needed
          ),
          Expanded(
            child: _buildBestSellerItem('assets/product2.png', 'Product 2', 200, 200), // Adjust dimensions as needed
          ),
          Expanded(
            child: _buildBestSellerItem('assets/product2.png', 'Product 3', 200, 200), // Adjust dimensions as needed
          ),
        ],
      ),
    ],
  );
}

Widget _buildBestSellerItem(String imagePath, String productName, double width, double height) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0), // Adjust the horizontal padding to decrease spacing
    child: Column(
      children: [
        Image.asset(
          imagePath,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 5),
        Text(
          productName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}



  Widget _buildGreenBackgroundContent() {
  return Container(
    color: Colors.green, // Green background color for the content
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // Padding for the content inside the box
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleRow("Services", "Resources", "Company"),
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildContentRow(
                [
                  "Our Menu",
                  "How it Works",
                  "Login",
                  "Sign Up",
                ],
                [
                  "FAQs",
                  "Recipe Categories",
                  "Terms and Conditions",
                  "Privacy Policy",
                ],
                [
                  "About Us",
                  "Press",
                  "Legal",
                ],
              ),
            ),
            SizedBox(width: 20), // Add space between content and images
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      Padding(
                        padding: EdgeInsets.only(top: 0.0),
                        child: Image.asset(
                          'assets/pic${i + 1}.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 0), // Add space between the rows of images and the sixth image with text
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.0),
                      child: Image.asset(
                        'assets/pic6.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                    SizedBox(width: 10), // Add space between the image and text
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '+92 3350344987',
                        style: TextStyle(color: Colors.white,fontSize: 15.0), // White text color
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}



  Widget _buildTitleRow(String title1, String title2, String title3) {
  return Row(
    children: [
      Text(
        title1,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 15.0), // White text color
      ),
      SizedBox(width: 230), // Add space between title1 and title2
      Text(
        title2,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // White text color
      ),
      SizedBox(width: 270), // Add space between title2 and title3
      Text(
        title3,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // White text color
      ),
    ],
  );
}


 Widget _buildContentRow(List<String> content1, List<String> content2, List<String> content3) {
  return Row(
    children: [
      _buildColumn(content1),
      SizedBox(width: 200), 
      _buildColumn(content2),
      SizedBox(width: 200), 
      _buildColumn(content3),
    ],
  );
}


  Widget _buildColumn(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  item,
                  style: TextStyle(color: Colors.white,fontSize: 15.0), // White text color
                ),
              ))
          .toList(),
    );
  }

  Widget _buildImagesRow(List<String> images, List<String> texts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var image in images)
          Image.asset(
            image,
            width: 100,
            height: 100,
          ),
        for (var text in texts)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.white,fontSize: 15.0), // White text color
            ),
          ),
      ],
    );
  }
}

class CarouselItem {
  final String imagePath;
  final String text;

  CarouselItem({required this.imagePath, required this.text});
}

