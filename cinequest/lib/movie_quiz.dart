import 'package:flutter/material.dart';
import 'package:cinequest/home_screen.dart'; // Import the HomeScreen widget
import 'package:cinequest/movie_quiz_transition.dart'; // Import the Transition widget

class MovieQuiz extends StatefulWidget {
  @override
  _MovieQuizState createState() => _MovieQuizState();
}

class _MovieQuizState extends State<MovieQuiz> {
  String? selectedGenre;
  String? selectedDirector;
  String? selectedStudio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Center(
              child: Image.asset(
                'assets/images/movie_4831192.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Taste Your Magic In Cinema',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            quizSection(
              title: 'WHICH ERA WAS THE MOVIE RELEASED?',
              options: ['1990', '1970', '2000', '1980'],
              value: selectedGenre,
              onChanged: (value) {
                setState(() {
                  selectedGenre = value;
                });
              },
            ),
            quizSection(
              title: 'WHICH DIRECTORS DIRECTED THE MOVIE?',
              options: ['Steven Spielberg', 'George Lucas', 'Christopher Nolan', 'Martin Scorsese'],
              value: selectedDirector,
              onChanged: (value) {
                setState(() {
                  selectedDirector = value;
                });
              },
            ),
            quizSection(
              title: 'WHICH MOVIE STUDIO PRODUCED THE MOVIE',
              options: ['Disney', 'Warner Brothers', 'Universal Studios', '20th Century Fox'],
              value: selectedStudio,
              onChanged: (value) {
                setState(() {
                  selectedStudio = value;
                });
              },
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(bottom: 20), // Adjust the value to your preference
              child: ElevatedButton(
                onPressed: () {
                  // Define what happens when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MovieTransition()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50),
                ),
                child: Text('CONTINUE', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quizSection({required String title, required List<String> options, required String? value, required void Function(String?) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...options.map((option) => RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: value,
            onChanged: onChanged,
          )).toList(),
        ],
      ),
    );
  }
}
