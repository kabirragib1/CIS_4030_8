// import 'package:cinequest/app_drawer.dart';
// import 'package:cinequest/logout_screen.dart';
// import 'package:cinequest/setting_screen.dart';
import 'package:cinequest/constants.dart';
import 'package:cinequest/watch_movie.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cinequest/trending_movie_slider.dart';
// import 'package:cinequest/top_rated_movie_slider.dart';
// import 'package:cinequest/upcoming_movie_slider.dart';
// import 'package:cinequest/saved_movies_screen.dart';

class ViewReviewPage extends StatelessWidget {

  final String movie_image_path; 
  final String movie_title;
  final double movie_vote_avg;

  ViewReviewPage({required this.movie_image_path, required this.movie_title, required this.movie_vote_avg});

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
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${Constants.image_path}${movie_image_path}'
                    )
                  )
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon(Icons.star, color: Colors.yellow, size: 50.0),
                    // Icon(Icons.star, color: Colors.yellow, size: 50.0),
                    // Icon(Icons.star, color: Colors.yellow, size: 50.0)
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child:  Text('FILM SCORE: ' + movie_vote_avg.toStringAsFixed(2) + '/10.0', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                    )
                  ]
                ),
                const Divider(
                  thickness: 3.0,
                  indent: 10.0,
                  endIndent: 10.0,
                  color: Colors.white,
                  height: 15.0,
                ),
                const Row (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child:  Text('CRITIC SCORES:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const Row (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('IMDB:', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
                          Text('ROTTEN TOMATOES:', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
                          Text('METACRITIC:', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
                        ],
                      ),
                    )
                  ],
                ),
                const Divider(
                  thickness: 3.0,
                  indent: 10.0,
                  endIndent: 10.0,
                  color: Colors.white,
                  height: 15.0,
                ),
                const Padding (
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AUDIENCE REVIEWS:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                    ]
                  ) 
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 5.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      color: Color.fromARGB(255, 196, 129, 13),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'MOVIE REVIEWER'
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow)
                                  ]
                                ),
                              
                              )
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Text('TEXT OF THE MOVIE REVIEW')
                        ],
                      ),
                    )
                  );  
                },
                childCount: 3,
              ),
            ),
          ),
        ]
      ),
    );
  }
}

