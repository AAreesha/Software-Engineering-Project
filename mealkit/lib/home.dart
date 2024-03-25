import 'package:flutter/material.dart';
import 'navigation.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Navigationbar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            _buildCarousel(), // Carousel section
            SizedBox(height: 20),
            _buildGreenBackgroundContent(), // Content with green background
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    double carouselHeight = 300; 
    double aspectRatio = 16 / 9;
    double maxWidth = carouselHeight * aspectRatio;

    return CarouselSlider(
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
        // Replace these placeholders with your actual images
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
                        style: TextStyle(color: Colors.white), // White text color
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
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // White text color
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
                  style: TextStyle(color: Colors.white), // White text color
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
              style: TextStyle(color: Colors.white), // White text color
            ),
          ),
      ],
    );
  }
}

