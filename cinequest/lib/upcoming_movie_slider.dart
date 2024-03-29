//upcoming_movie
import 'package:cinequest/constants.dart';
import 'package:cinequest/movie.dart';
import 'package:cinequest/movie_model.dart';
import 'package:cinequest/movie_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpcomingMoviesSlider extends StatelessWidget {
  const UpcomingMoviesSlider();

  @override
  Widget build(BuildContext context) {
    final moviesListModel = Provider.of<MovieModel>(context);
    final upcomingMovies = moviesListModel.get_all_upcoming_movies;

    return upcomingMovies.isNotEmpty
        ? SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: upcomingMovies.length,
              itemBuilder: (context, index) {
                final upcoming_movie = upcomingMovies[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoviePage(
                            movie_image_path: upcoming_movie.movie_image_path,
                            movie_title: upcoming_movie.movie_title,
                            movie_synopsis: upcoming_movie.movie_synopsis,
                            movie_release_date: upcoming_movie.movie_release_date,
                            movie_vote_avg: upcoming_movie.movie_vote_avg,
                            movieId: upcoming_movie.id
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height: 250,
                            width: 150,
                            child: upcoming_movie.movie_image_path != ''
                            ? Image.network(
                              '${Constants.image_path}${upcoming_movie.movie_image_path}',
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            )
                            : Container()
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: FavoriteIcon(
                           upcoming_movie
                          ),
                        ),
                      ],
                    ),
                  ),
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