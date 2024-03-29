import 'package:cinequest/constants.dart';
import 'package:cinequest/movie_model.dart';
import 'package:cinequest/movie_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinequest/movie.dart'; 
class NowPlayingMoviesSlider extends StatelessWidget {
  const NowPlayingMoviesSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesListModel = Provider.of<MovieModel>(context);
    final nowPlayingMovies = moviesListModel.get_all_now_playing_movies;

    return nowPlayingMovies.isNotEmpty
        ? SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // apply scroll effects
              physics: const BouncingScrollPhysics(),
              itemCount: nowPlayingMovies.length, // show 10 movies
              itemBuilder: (context, index) {
                final now_playing_movie = nowPlayingMovies[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoviePage(
                            movie_image_path: now_playing_movie.movie_image_path,
                            movie_title: now_playing_movie.movie_title,
                            movie_synopsis: now_playing_movie.movie_synopsis,
                            movie_release_date: now_playing_movie.movie_release_date,
                            movie_vote_avg: now_playing_movie.movie_vote_avg,
                            movieId: now_playing_movie.id
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 250,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage('${Constants.image_path}${now_playing_movie.movie_image_path}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: FavoriteIcon(now_playing_movie), // Pass the Movie object here
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