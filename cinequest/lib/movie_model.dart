import 'dart:convert';
import 'dart:async';
import 'package:cinequest/constants.dart';
import 'package:cinequest/movie_watch_country.dart';
import 'package:cinequest/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'mongodb.dart';

class MovieModel extends ChangeNotifier{
  String _userEmail = '';
  static const trending_movie_URL = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.API_key}';
  static const top_rated_movie_URL = 'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.API_key}';
  static const now_playing_movie_URL = 'https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.API_key}';
    static const popular_movie_URL = 'https://api.themoviedb.org/3/movie/popular?api_key=${Constants.API_key}';


  // static const now_playing_movie_URL = 'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_release_type=2|3&release_date.gte={min_date}&release_date.lte={max_date}&api_key=${Constants.API_key}';
  static const countries_names_URL = 'https://api.themoviedb.org/3/configuration/countries?api_key=${Constants.API_key}';

  List<Movie> all_trending_movies = [];
  List<Movie> get get_all_trending_movies => all_trending_movies;
  bool trending_movies_loaded = true;
  bool get get_trending_movies_loaded=> trending_movies_loaded;

  List<Movie> all_top_rated_movies = [];
  List<Movie> get get_all_top_rated_movies => all_top_rated_movies;
  bool top_rated_movies_loaded = true;
  bool get get_top_rated_movies_loaded=> top_rated_movies_loaded;

  List<Movie> all_upcoming_movies = [];
  List<Movie> get get_all_upcoming_movies => all_upcoming_movies;
  bool upcoming_movies_loaded = true;
  bool get get_upcoming_movies_loaded=> upcoming_movies_loaded;

  List<Movie> all_now_playing_movies = [];
  List<Movie> get get_all_now_playing_movies => all_now_playing_movies;
  bool now_playing_movies_loaded = true;
  bool get get_now_playing_movies_loaded => now_playing_movies_loaded;

  List<Movie> savedMovies = [];
  List<Movie> get get_savedMovies => savedMovies;

  List<MovieWatchCountry> movie_watch_country_data = [];
  List<MovieWatchCountry> get get_all_countries => movie_watch_country_data;

  List<Movie> searchResults = [];
  List<Movie> get get_searchResults => searchResults;

  void loadSavedMovies() async {
    try {
      // Retrieve the list of favorite movies as a list of maps
      List<Map<String, dynamic>> movieMaps = await MongoDatabase.getFavoriteMovies(_userEmail);

      // Convert the list of maps to a list of Movie objects
      savedMovies = movieMaps.map((movieMap) => Movie.fromJson(movieMap)).toList();

      notifyListeners();
    } catch (e) {
      print('Error loading saved movies: $e');
      // Handle any errors, possibly by notifying the user
    }
  }

  void setUserEmail(String email) {
    _userEmail = email;
    loadSavedMovies();
    notifyListeners();
  }

  String get userEmail => _userEmail;

  //saving movies
  void toggleFavorite(BuildContext context, Movie movie) async {
    String message; // Declare the message variable

    int index = savedMovies.indexWhere((savedMovie) => savedMovie.id == movie.id);
    if (index < 0) {
      // If not, save it
      savedMovies.add(movie);
      // Use the appropriate method based on the information you have (ID or full data)
      await MongoDatabase.addFavoriteMovieByData(_userEmail, movie.toJson());
      message = 'Movie Saved'; // Assign a value to message
    } else {
      // If it is saved, remove it
      savedMovies.removeAt(index);
      // Use the method that removes by matching the full data structure
      await MongoDatabase.removeFavoriteMovieByData(_userEmail, movie.toJson());
      message = 'Movie Removed'; // Assign a value to message
    }
    notifyListeners();
    loadSavedMovies();
    notifyListeners();


    // Create a GlobalKey for the AlertDialog
    final GlobalKey<State> _alertDialogKey = GlobalKey<State>();

    // Show the AlertDialog with larger font size
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key: _alertDialogKey, // Assign the GlobalKey to the AlertDialog
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          content: Text(
            message,
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20), 
            textAlign: TextAlign.center, // Customize the font size here
          ),
        );
      },
    );

    // Close the AlertDialog after 2 seconds
    Timer(Duration(seconds: 2), () {
      // Dismiss the AlertDialog using the GlobalKey
      Navigator.of(_alertDialogKey.currentContext!).pop();
    });
  }


  MovieModel() {
    get_trending_movies();
    get_top_rated_movies();
    get_upcoming_movies();
    get_now_playing_movies();
    get_movie_watch_countries();

  }

  void searchMoviesByGenre(int genreId) async {
    final String genreSearchUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.API_key}&with_genres=$genreId';
    try {
      final response = await http.get(Uri.parse(genreSearchUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['results'];
        searchResults = data.map((json) => Movie.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load movies by genre');
      }
    } catch (e) {
      throw Exception('Error fetching movies by genre: $e');
    }
  }

  void searchMoviesByName(String query) async {
    final String nameSearchUrl = 'https://api.themoviedb.org/3/search/movie?api_key=${Constants.API_key}&query=${query}';
    try {
      final response = await http.get(Uri.parse(nameSearchUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['results'];
        searchResults = data.map((json) => Movie.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load movie');
      }
    } catch (e) {
      throw Exception('Error fetching movie: $e');
    }
  }

  void  get_trending_movies() async {
    final response = await http.get(Uri.parse(trending_movie_URL));
    if (response.statusCode == 200) {
      trending_movies_loaded = false;
      notifyListeners();

      var moviesJSON = jsonDecode(response.body)['results'] as List;
      all_trending_movies = moviesJSON.map((movie) => Movie.fromJson(movie)).toList();
      await Future.delayed(Duration(seconds: 5)); 

      trending_movies_loaded = true;
      notifyListeners();
    } else {
      trending_movies_loaded = false;
      notifyListeners();
      throw Exception('Something happended');
      
    }
  }

  void get_top_rated_movies() async {
    final response = await http.get(Uri.parse(top_rated_movie_URL));
    if (response.statusCode == 200) {
      top_rated_movies_loaded = false;
      notifyListeners();

      var moviesJSON = jsonDecode(response.body)['results'] as List;
      all_top_rated_movies = moviesJSON.map((movie) => Movie.fromJson(movie)).toList();
      await Future.delayed(Duration(seconds: 5)); 

      top_rated_movies_loaded = true;
      notifyListeners();
    } else {
      top_rated_movies_loaded = false;
      notifyListeners();
      throw Exception('Something happended');
      
    }
  }

  void get_upcoming_movies() async {
    final current_date = DateTime.now();
    String current_date_str = current_date.toIso8601String();
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/discover/movie?api_key=${Constants.API_key}&primary_release_date.gte=${current_date_str.split('T')[0]}'));
    // final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/upcoming?api_key=01474bb725783ef4f6c03ee7decb63be'));
    if (response.statusCode == 200) {
      upcoming_movies_loaded = false;
      notifyListeners();

      var moviesJSON = jsonDecode(response.body)['results'] as List;
      all_upcoming_movies = moviesJSON.map((movie) => Movie.fromJson(movie)).toList();
      await Future.delayed(Duration(seconds: 5)); 

      upcoming_movies_loaded = true;
      notifyListeners();
    } else {
      upcoming_movies_loaded = false;
      notifyListeners();
      throw Exception('Something happended');
      
    }
  }

  void get_now_playing_movies() async {
    final response = await http.get(Uri.parse(now_playing_movie_URL));
    if (response.statusCode == 200) {
      now_playing_movies_loaded = false;
      notifyListeners();

      var moviesJSON = jsonDecode(response.body)['results'] as List;
      all_now_playing_movies = moviesJSON.map((movie) => Movie.fromJson(movie)).toList();
      await Future.delayed(Duration(seconds: 5)); 

      now_playing_movies_loaded = true;
      notifyListeners();
    } else {
      now_playing_movies_loaded = false;
      notifyListeners();
      throw Exception('Something happended');
      
    }
  }

   void get_movie_watch_countries() async {
    final response = await http.get(Uri.parse(countries_names_URL));
     if (response.statusCode == 200) {
     List<Map<String, dynamic>> jsonResponse = List<Map<String, dynamic>>.from(json.decode(response.body));
     movie_watch_country_data = jsonResponse.map((data) {
        return MovieWatchCountry(
          country_short_form: data['iso_3166_1'],
          english_name: data['english_name'],
          native_name: data['native_name'],
        );
      }).toList();
      notifyListeners();
     } else {
      throw Exception('Something happended');
    }
  }

}