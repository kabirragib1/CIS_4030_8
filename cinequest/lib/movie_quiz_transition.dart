import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cinequest/home_screen.dart'; // Ensure this is the correct path to your HomeScreen

class MovieTransition extends StatefulWidget {
  @override
  _MovieTransitionState createState() => _MovieTransitionState();
}

class _MovieTransitionState extends State<MovieTransition> {
  @override
  void initState() {
    super.initState();
    // Navigate to the HomeScreen after a 5-second delay
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // No back arrow
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column( // Use Column to align children vertically
        mainAxisAlignment: MainAxisAlignment.start, // Align at the start of the screen
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40), // This will be at the top of the column
          Image.asset(
            'assets/images/popcorn.png',
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 10),
          Text(
            'YOUR MAGIC IN CINEMA!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded( // This will expand and push the below content to be more centered
            child: Center( // Center the text in the expanded space
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Bravo! You've aced the movie quiz with a perfect score of 10/10! Your cinematic savvy has earned you CineQuest Novice Badge",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
