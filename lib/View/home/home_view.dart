import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mealkit/widgets/navigation_bar/navigation_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double carouselHeight = 300; // Example height of the carousel
    double aspectRatio = 16 / 9; // Example aspect ratio of the carousel
    double maxWidth = carouselHeight * aspectRatio;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Navigationbar(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20), // Add space between navigation bar and carousel
          CarouselSlider(
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
          ),
          // Add more content below the carousel if needed
        ],
      ),
    );
  }
}
