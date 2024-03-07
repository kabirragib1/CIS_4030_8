import 'package:cinequest/constants.dart';
import 'package:cinequest/movie_model.dart';
import 'package:cinequest/movie_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class topRatedMoviesSlider extends StatelessWidget {
  const topRatedMoviesSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final moviesListModel = Provider.of<MovieModel>(context);
    final topRatedMovies = moviesListModel.get_all_top_rated_movies;
    
   return topRatedMovies.isNotEmpty
   ? SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
         // apply scroll effects
        physics: const BouncingScrollPhysics(),
        itemCount: topRatedMovies.length, // show 10 movies 
        itemBuilder:(context, index) {
          final top_rated_movie =  topRatedMovies[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) =>  MoviePage(movie_image_path: top_rated_movie.movie_image_path, movie_title: top_rated_movie.movie_title, movie_synopsis: top_rated_movie.movie_synopsis, movie_release_date: top_rated_movie.movie_release_date, movie_vote_avg: top_rated_movie.movie_vote_avg)));
              },  
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                height: 200,
                width: 150,
                child: Image.network(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  '${Constants.image_path}${top_rated_movie.movie_image_path}'
                )
              ),
            ),
          )
          );
        },
      ),
    )
    : Center(child: CircularProgressIndicator());
  }
}