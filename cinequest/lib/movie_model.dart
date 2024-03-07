import 'dart:convert';
import 'package:cinequest/constants.dart';
import 'package:cinequest/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieModel extends ChangeNotifier{
  static const trending_movie_URL = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.API_key}';
  static const top_rated_movie_URL = 'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.API_key}';
   static const upcoming_movie_URL = 'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.API_key}';

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

  MovieModel() {
    get_trending_movies();
    get_top_rated_movies();
    get_upcoming_movies();

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
    final response = await http.get(Uri.parse(upcoming_movie_URL));
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
}