import 'package:cinequest/constants.dart';
import 'package:cinequest/movie_model.dart';
import 'package:cinequest/movie_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class trendingMovieSlider extends StatelessWidget {
  const trendingMovieSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final moviesListModel = Provider.of<MovieModel>(context);
    final trendingMovies = moviesListModel.get_all_trending_movies;
    return trendingMovies.isNotEmpty
    ? SizedBox(
      width: double.infinity, 
      child: CarouselSlider.builder(
        itemCount: trendingMovies.length, 
        options: CarouselOptions(
          height: 300,
          autoPlay: true, // auto play the trending movies
          autoPlayInterval: const Duration(seconds: 2), // interval for the movies to rotate
          viewportFraction: 0.55, // fraction of the viewport that each item occupies
          enlargeCenterPage: true, // make center movie larger 
          pageSnapping: true,
          autoPlayCurve: Curves.easeInOutCirc,
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          final trending_movie =  trendingMovies[itemIndex];
           return GestureDetector(
            child:  ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 300,
                width: 200,
                child: Image.network(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  '${Constants.image_path}${trending_movie.movie_image_path}'
                )
              ),
            ),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  MoviePage(movie_image_path: trending_movie.movie_image_path, movie_title: trending_movie.movie_title, movie_synopsis: trending_movie.movie_synopsis, movie_release_date: trending_movie.movie_release_date, movie_vote_avg: trending_movie.movie_vote_avg, movieId: trending_movie.id)));
            }
          );  
        } 
      ),
    )
    : Center(child: CircularProgressIndicator());
  }
}