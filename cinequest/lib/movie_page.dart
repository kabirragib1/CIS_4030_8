// import 'package:cinequest/app_drawer.dart';
// import 'package:cinequest/logout_screen.dart';
// import 'package:cinequest/setting_screen.dart';
import 'package:cinequest/view_reviews.dart';
import 'package:cinequest/watch_movie.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:cinequest/trending_movie_slider.dart';
// import 'package:cinequest/top_rated_movie_slider.dart';
// import 'package:cinequest/upcoming_movie_slider.dart';
// import 'package:cinequest/saved_movies_screen.dart';

class MoviePage extends StatefulWidget {
   const MoviePage({super.key});

    @override
    State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [  
                Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 300,
                      width: 150,
                      color: Color.fromARGB(255, 250, 178, 54),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Movie Title', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 25),
                          Text('Director: ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 25),
                          Text('Release: ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 25),
                          Text('Duration: ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 25),
                          Text('Studio: ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 25),
                          Text('Box Office: ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ]
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 3.0,
                  indent: 10.0,
                  endIndent: 10.0,
                  color: Colors.white,
                  height: 15.0,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child:  Text('SYNOPSIS:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    )
                  ]
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child:  Text('', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
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
                      child:  Text('WHERE TO WATCH:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
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
                          Text('DISNEY+', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text('NETFLIX', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                          Text('HBO MAX', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
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
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  ViewReviewPage()));
                  }, 
                  child: const Text('VIEW REVIEWS', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 250, 178, 54),
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                  )
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                         Navigator.push(context,MaterialPageRoute(builder: (context) =>  WatchMoviePage()));
                      }, 
                      child: Text('WATCH', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 250, 178, 54),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                      )
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: (){}, 
                      child: Text('INTERACT', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 250, 178, 54),
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                      )
                    ),
                  ]
                )
              ]
            )
          ),
        ],
      ),
      // drawer: AppDrawer()
    );
  }
}

