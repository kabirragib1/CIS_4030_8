import 'package:flutter/material.dart';
import 'package:cinequest/movie.dart';
import 'package:cinequest/movie_model.dart';
import 'package:cinequest/movie_page.dart';
import 'package:cinequest/constants.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> _searchResults = [];
  String _searchQuery = '';

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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  _searchMovies(value);
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final movie = _searchResults[index];
                return InkWell(
                  onTap: () {
                    // Navigate to the movie page when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoviePage(
                          movie_image_path: movie.movie_image_path,
                          movie_title: movie.movie_title,
                          movie_synopsis: movie.movie_synopsis,
                          movie_release_date: movie.movie_release_date,
                          movie_vote_avg: movie.movie_vote_avg,
                          movieId: movie.id
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: movie.movie_image_path.isNotEmpty
                        ? Image.network(
                            '${Constants.image_path}${movie.movie_image_path}',
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          )
                        : Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey,
                          ),
                    title: Text(movie.movie_title),
                    subtitle: Text(movie.movie_release_date),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchMovies(String query) async {
    try {
      final searchResults = await MovieModel.searchMovies(query);
      setState(() {
        _searchResults = searchResults;
      });
    } catch (e) {
      print('Error searching movies: $e');
    }
  }
}
