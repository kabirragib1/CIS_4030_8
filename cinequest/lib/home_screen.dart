import 'package:cinequest/movie_model.dart';
import 'package:cinequest/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cinequest/trending_movie_slider.dart';
import 'package:cinequest/top_rated_movie_slider.dart';
import 'package:cinequest/upcoming_movie_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

// late Future<List<Movie>> trending_movies;

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   trending_movies = MovieModel().get_trending_movies();
  //   print('Hello');
  // }
  @override
  Widget build(BuildContext context) {
    final moviesListModel = Provider.of<MovieModel>(context);
    final all_trending_movies = moviesListModel.get_all_trending_movies;
    // late Future<List<Movie>> trending_movies = all_trending_movies as Future<List<Movie>>;
    // print(moviesListModel.get_all_trending_movies[0].movie_title);
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
          //  moviesListModel.get_trending_movies_loaded
          //   ? const trendingMovieSlider()
          //   : const Center(child: CircularProgressIndicator()), 
            
            const TrendingMovieSlider(),
            // SizedBox(
            //   child: FutureBuilder(
            //     future: trending_movies, 
            //     builder: (context, snapshot) {
            //       if (snapshot.hasError) {
            //         return Center(
            //           child: Text(snapshot.error.toString()),
            //         );
            //       } else if (snapshot.hasData) {
            //         return const trendingMovieSlider();
            //       } else {
            //         return const Center(child: CircularProgressIndicator());
            //       }
            //     }
            //   )
            // ),
            const SizedBox(height: 35),
            Text(
              'Top Rated Movies',
              style: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.w500)
            ),
            const SizedBox(height: 35),
            // list of scrollable widgets 
            const TopRatedMoviesSlider(),
            const SizedBox(height: 35),
            Text(
              'Upcoming Movies',
              style: GoogleFonts.quicksand(fontSize: 25, fontWeight: FontWeight.w500)
            ),
            const SizedBox(height: 35),
            UpcomingMoviesSlider()
          ],
        ),
      ),
      ),
      // drawer 
      drawer: AppDrawer(),
    );
  }
}