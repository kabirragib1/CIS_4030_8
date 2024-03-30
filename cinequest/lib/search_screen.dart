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
  int? _selectedGenreId; // Define selectedGenreId variable
  String _searchType = 'Search By...'; // Default search type

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
            child: DropdownButton<String>(
              value: _searchType,
              onChanged: (newValue) {
                setState(() {
                  _searchType = newValue!;
                  if (_searchType == 'Search By...') {
                    // Reset search type and query
                    _searchType = 'Search By...';
                    _searchQuery = '';
                  } else if (_searchType == 'Search By Genre') {
                    // Reset search query and selected genre ID
                    _searchQuery = '';
                    _selectedGenreId = null;
                  }
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: 'Search By...',
                  child: Text('Search By...'),
                ),
                DropdownMenuItem<String>(
                  value: 'Search By Movie Name',
                  child: Text('Search By Movie Name'),
                ),
                DropdownMenuItem<String>(
                  value: 'Search By Genre',
                  child: Text('Search By Genre'),
                ),
              ],
            ),
          ),
          if (_searchType == 'Search By Movie Name')
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
                  hintText: 'Search By Movie Name...',
                ),
              ),
            ),
          if (_searchType == 'Search By Genre')
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<int>(
                value: _selectedGenreId,
                onChanged: (newValue) {
                   setState(() {
                     _selectedGenreId = newValue;
                     _searchMovies(_searchQuery, _selectedGenreId);
                   });
                },
                items: [
                  DropdownMenuItem<int>(
                    value: null,
                    child: Text('All Genres'),
                  ),
                  DropdownMenuItem<int>(
                    value: 28,
                    child: Text('Action'),
                  ),
                  DropdownMenuItem<int>(
                    value: 12,
                    child: Text('Adventure'),
                  ),
                  DropdownMenuItem<int>(
                    value: 16,
                    child: Text('Animation'),
                  ),
                  DropdownMenuItem<int>(
                    value: 35,
                    child: Text('Comedy'),
                  ),
                  DropdownMenuItem<int>(
                    value: 80,
                    child: Text('Crime'),
                  ),
                  DropdownMenuItem<int>(
                    value: 99,
                    child: Text('Documentary'),
                  ),
                  DropdownMenuItem<int>(
                    value: 18,
                    child: Text('Drama'),
                  ),
                  DropdownMenuItem<int>(
                    value: 10751,
                    child: Text('Family'),
                  ),
                  DropdownMenuItem<int>(
                    value: 14,
                    child: Text('Fantasy'),
                  ),
                  DropdownMenuItem<int>(
                    value: 36,
                    child: Text('History'),
                  ),
                  DropdownMenuItem<int>(
                    value: 27,
                    child: Text('Horror'),
                  ),
                  DropdownMenuItem<int>(
                    value: 10402,
                    child: Text('Music'),
                  ),
                  DropdownMenuItem<int>(
                    value: 9648,
                    child: Text('Mystery'),
                  ),
                  DropdownMenuItem<int>(
                    value: 10749,
                    child: Text('Romance'),
                  ),
                  DropdownMenuItem<int>(
                    value: 878,
                    child: Text('Science Fiction'),
                  ),
                  DropdownMenuItem<int>(
                    value: 10770,
                    child: Text('TV Movie'),
                  ),
                  DropdownMenuItem<int>(
                    value: 53,
                    child: Text('Thriller'),
                  ),
                  DropdownMenuItem<int>(
                    value: 10752,
                    child: Text('War'),
                  ),
                  DropdownMenuItem<int>(
                    value: 37,
                    child: Text('Western'),
                  ),
                ],
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
                          movieId: movie.id,
                          movie_original_title: movie.movie_original_title,
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

  Future<void> _searchMovies(String query, [int? genreId]) async {
    try {
      List<Movie> searchResults = [];
      if (genreId != null) {
        // Implement logic to search movies by genre
        searchResults = await MovieModel.searchMoviesByGenre(genreId);
      } else {
        // Existing logic to search by movie title
        searchResults = await MovieModel.searchMovies(query);
      }

      setState(() {
        _searchResults = searchResults;
      });
    } catch (e) {
      print('Error searching movies: $e');
    }
  }
}