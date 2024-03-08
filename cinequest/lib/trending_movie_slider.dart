import 'package:cinequest/constants.dart';
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
                        child: IconButton(
                          icon: Icon(
                            isHeartClickedList[itemIndex]
                                ? Icons.favorite // Use filled heart icon
                                : Icons.favorite_border, // Use border heart icon
                            color: isHeartClickedList[itemIndex]
                                ? Colors.red // Change the color to red if heart clicked
                                : Colors.white, // Change the color to white if not clicked
                            size: 24, // Customize the size if needed
                          ),
                          onPressed: () {
                            setState(() {
                              // Toggle the state of heart clicked
                              isHeartClickedList[itemIndex] =
                                  !isHeartClickedList[itemIndex];
                            });
                          },
                        ),
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
                                )));
                  },
                );
              },
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
