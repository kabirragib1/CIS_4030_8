import 'package:cinequest/movie_model.dart';
import 'package:cinequest/app_drawer.dart';
import 'package:cinequest/now_playing_movie_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cinequest/trending_movie_slider.dart';
import 'package:cinequest/top_rated_movie_slider.dart';
import 'package:cinequest/upcoming_movie_slider.dart';
import 'package:provider/provider.dart';
import 'package:cinequest/search_screen.dart';

class HomeScreen extends StatefulWidget {
  final String? userEmail; // Add a field for the user's email

  const HomeScreen({super.key, this.userEmail}); // Modify the constructor to accept userEmail

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearchBarVisible = false;

  @override
  Widget build(BuildContext context) {
    final moviesListModel = Provider.of<MovieModel>(context);
    final all_trending_movies = moviesListModel.get_all_trending_movies;
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
       actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearchBarVisible = !_isSearchBarVisible;
              });
              if (_isSearchBarVisible) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
              }
            },
          ),
        ],
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
            const TrendingMovieSlider(),
            const SizedBox(height: 35),
            Text(
              'Top Rated Movies',
              style: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.w500)
            ),
            const SizedBox(height: 35),
            // list of scrollable widgets 
              TopRatedMoviesSlider(userEmail: widget.userEmail),
              const SizedBox(height: 35),
            Text(
              'Upcoming Movies',
              style: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.w500)
            ),
            const SizedBox(height: 35),
            UpcomingMoviesSlider(),
            const SizedBox(height: 35),
            Text(
              'Now Playing Movies',
              style: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.w500)
            ),
            const SizedBox(height: 35),
            NowPlayingMoviesSlider(),
          ],
        ),
      ),
      ),
      // drawer 
      drawer: AppDrawer(),
    );
  }
}

