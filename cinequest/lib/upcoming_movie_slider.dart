//upcoming_movie
import 'package:cinequest/constants.dart';
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
            height: 200,
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
                            movieId: upcoming_movie.id,
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height: 200,
                            width: 150,
                            child: Image.network(
                              '${Constants.image_path}${upcoming_movie.movie_image_path}',
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: FavoriteIcon(
                            isFavorite: upcoming_movie.isFavorite,
                            onFavoriteChanged: (isFavorite) {
                              moviesListModel.toggleFavorite(context, upcoming_movie);
                            },
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

class FavoriteIcon extends StatelessWidget {
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;

  const FavoriteIcon({
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onFavoriteChanged(!isFavorite);
      },
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.white,
        size: 24,
      ),
    );
  }
}

