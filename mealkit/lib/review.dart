import 'package:flutter/material.dart';


class Review {
  final String text;
  final String imagePath;

  Review({required this.text, required this.imagePath});
}


class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _currentIndex = 0;

  final List<Review> reviews = [
    Review(
      text: 'This is a fantastic product!',
      imagePath: 'assets/review1.png',
    ),
    Review(
      text: 'Excellent service and quality!',
      imagePath: 'assets/review2.png',
    ),
    // Add more reviews as needed
  ];

  void _nextReview() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % reviews.length;
    });
  }

  void _prevReview() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % reviews.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Reviews'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Image.asset(
                    reviews[_currentIndex].imagePath,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    reviews[_currentIndex].text,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _prevReview,
                ),
                SizedBox(width: 20.0),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: _nextReview,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
