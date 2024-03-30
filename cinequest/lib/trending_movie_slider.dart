import 'package:cinequest/constants.dart';
import 'package:cinequest/movie.dart';
import 'package:cinequest/movie_model.dart';
import 'package:cinequest/movie_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class TrendingMovieSlider extends StatefulWidget {
  const TrendingMovieSlider();

  @override
  _TrendingMovieSliderState createState() => _TrendingMovieSliderState();
}

class _TrendingMovieSliderState extends State<TrendingMovieSlider> {
  // List to keep track of whether the heart is clicked or not
  List<bool> isHeartClickedList = [];

  @override
  Widget build(BuildContext context) {
    final moviesListModel = Provider.of<MovieModel>(context);
    final trendingMovies = moviesListModel.get_all_trending_movies;

    // Initialize the list with false (no heart clicked)
    if (isHeartClickedList.isEmpty) {
      isHeartClickedList = List<bool>.filled(trendingMovies.length, false);
    }

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
                final trendingMovie = trendingMovies[itemIndex];
                return GestureDetector(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: 300,
                          width: 200,
                          child: Image.network(
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            '${Constants.image_path}${trendingMovie.movie_image_path}',
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: FavoriteIcon(trendingMovie)
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoviePage(
                                  movie_image_path:
                                      trendingMovie.movie_image_path,
                                  movie_title: trendingMovie.movie_title,
                                  movie_synopsis:
                                      trendingMovie.movie_synopsis,
                                  movie_release_date:
                                      trendingMovie.movie_release_date,
                                  movie_vote_avg:
                                      trendingMovie.movie_vote_avg,
                                  movieId: trendingMovie.id,
                                  movie_original_title: trendingMovie.movie_original_title,
                                  
                                )));
                  },
                );
              },
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}

class FavoriteIcon extends StatefulWidget {
  final Movie movie;

  FavoriteIcon(this.movie);

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    final moviesListModel = Provider.of<MovieModel>(context);
    final saved_movies = moviesListModel.get_savedMovies;

    bool isFavorite = false;
    if (saved_movies.isNotEmpty && saved_movies.indexWhere((movie) => movie.id == widget.movie.id) >= 0) {
      isFavorite = true;
    } else {
      isFavorite = false;
    }

    return GestureDetector(
      onTap: () {
        Provider.of<MovieModel>(context, listen: false).toggleFavorite(context, widget.movie);
      },
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.white,
        size: 24,
      ),
    );
  }
}

