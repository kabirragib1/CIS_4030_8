import 'package:cinequest/app_drawer.dart';
import 'package:cinequest/logout_screen.dart';
import 'package:cinequest/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cinequest/trending_movie_slider.dart';
import 'package:cinequest/top_rated_movie_slider.dart';
import 'package:cinequest/upcoming_movie_slider.dart';
import 'package:cinequest/saved_movies_screen.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding (
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trending Movies',
                style: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            const SizedBox(height: 35),
            const trendingMovieSlider(),
            const SizedBox(height: 35),
            Text(
              'Top Rated Movies',
              style: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.w500)
            ),
            const SizedBox(height: 35),
            // list of scrollable widgets 
            topRatedMoviesSlider(),
            const SizedBox(height: 35),
            Text(
              'Upcoming Movies',
              style: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.w500)
            ),
            const SizedBox(height: 35),
            upcomingMoviesSlider()
          ],
        ),
      ),
      ),
      // drawer 
      drawer: AppDrawer(),
    );
  }
}

