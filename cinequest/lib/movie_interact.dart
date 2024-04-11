import 'package:flutter/material.dart';
import 'package:cinequest/constants.dart';
import 'package:cinequest/sign_quiz.dart'; // Assuming you have this class
import 'package:cinequest/movie_quiz.dart';

class MovieInteract extends StatelessWidget {
  final String movie_image_path;
  final String movie_title;
  final double movie_vote_avg;

  MovieInteract({
    required this.movie_image_path,
    required this.movie_title,
    required this.movie_vote_avg,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          height: 80,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Center(child: Text(movie_title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                const SizedBox(height: 15.0),
                Center(
                    child: SizedBox(
                        height: 300,
                        width: 200,
                        child: Image.network(
                          '${Constants.image_path}$movie_image_path',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        )
                    )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the SignUpQuiz page when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MovieQuiz()),
                      );
                    },
                    child: Text(
                      'Take Movie Quiz',
                      style: TextStyle(fontSize: 20, color: Colors.black), // Set font size to 20 and text color to white
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow, // Button background color
                      foregroundColor: Colors.white, // Text color for button
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('AUDIENCE REVIEWS:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 20.0),
                    color: Color.fromARGB(255, 196, 129, 13),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MOVIE REVIEWER #${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('Sample text of the movie review. This should be replaced with actual review content.'),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 3, // Replace 3 with the actual number of reviews
              ),
            ),
          ),
        ],
      ),
    );
  }
}
