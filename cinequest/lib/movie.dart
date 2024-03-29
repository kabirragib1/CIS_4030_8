import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cinequest/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class Movie {
  String movie_title;
  String movie_image;
  String movie_image_path;
  String movie_original_title;
  String movie_synopsis;
  String movie_release_date;
  double movie_vote_avg;
  int id;

  Movie(this.movie_title, this.movie_image, this.movie_image_path, this.movie_original_title, this.movie_synopsis, this.movie_release_date, this.movie_vote_avg, this.id);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      json['title'] as String,
      json['backdrop_path'] != null ? json['backdrop_path'] as String : '',
      json['poster_path'] as String,
      json['original_title'] as String,
      json['overview'] as String,
      json['release_date'] as String,
      json['vote_average'] as double,
      json['id'] as int
    );
  }

  static Future<List<Movie>> searchMovies(String query) async {
  final Set<int> addedMovieIds = {};
  final List<Movie> searchResults = [];
  try {
    // fetch trending movies
    final trendingMovies = await _fetchTrendingMovies();
    for (final movie in trendingMovies) {
      if (!addedMovieIds.contains(movie.id) &&
          movie.movie_title.toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(movie);
        addedMovieIds.add(movie.id);
      }
    }

    // fetch popular movies
    final popularMovies = await _fetchMoviesByPopularity();
    for (final movie in popularMovies) {
      if (!addedMovieIds.contains(movie.id) &&
          movie.movie_title.toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(movie);
        addedMovieIds.add(movie.id);
      }
    }

    // fetch now playing movies 
    final nowPlayingMovies = await _fetchNowPlayingMovies();
    for (final movie in nowPlayingMovies) {
      if (!addedMovieIds.contains(movie.id) &&
          movie.movie_title.toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(movie);
        addedMovieIds.add(movie.id);
      }
    }

    // fetch upcoming movies 
    final upcomingMovies = await _fetchUpcomingMovies();
    for (final movie in upcomingMovies) {
      if (!addedMovieIds.contains(movie.id) &&
          movie.movie_title.toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(movie);
        addedMovieIds.add(movie.id);
      }
    }

    // fetch top rated movies 
    final topRatedMovies = await _fetchTopRatedMovies();
    for (final movie in topRatedMovies) {
      if (!addedMovieIds.contains(movie.id) &&
          movie.movie_title.toLowerCase().contains(query.toLowerCase())) {
        searchResults.add(movie);
        addedMovieIds.add(movie.id);
      }
    }
    return searchResults;
  } catch (e) {
    throw Exception('Error searching movies: $e');
  }
}

  // trending movies 
  static Future<List<Movie>> _fetchTrendingMovies() async {
    final Map<int, Movie> trendingMoviesMap = {};
    const apiKey = Constants.API_key;
    const apiUrl = 'https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['results'];
        data.forEach((json) {
          final movie = Movie.fromJson(json);
          trendingMoviesMap[movie.id] = movie;
        });
        return trendingMoviesMap.values.toList();
      } else {
        throw Exception('Failed to load trending movies');
      }
    } catch (e) {
      throw Exception('Error fetching trending movies: $e');
    }
  }

  // popular movies
  static Future<List<Movie>> _fetchMoviesByPopularity() async {
    final Map<int, Movie> popularMoviesMap = {};
    const apiKey = Constants.API_key;
    const apiUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['results'];
        data.forEach((json) {
          final movie = Movie.fromJson(json);
          popularMoviesMap[movie.id] = movie;
        });
        return popularMoviesMap.values.toList();
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }

  // now playing movies 
  static Future<List<Movie>> _fetchNowPlayingMovies() async {
    final Map<int, Movie> nowPlaingMoviesMap = {};
    const apiKey = Constants.API_key;
    const apiUrl = 'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['results'];
        data.forEach((json) {
          final movie = Movie.fromJson(json);
          nowPlaingMoviesMap[movie.id] = movie;
        });
        return nowPlaingMoviesMap.values.toList();
      } else {
        throw Exception('Failed to load now playing movies');
      }
    } catch (e) {
      throw Exception('Error fetching now playing movies: $e');
    }
  }

  // upcoming movies 
  static Future<List<Movie>> _fetchUpcomingMovies() async {
    final Map<int, Movie> upcomingMoviesMap = {};
    const apiKey = Constants.API_key;
    final current_date = DateTime.now();
    String current_date_str = current_date.toIso8601String();
    final apiUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=${apiKey}&primary_release_date.gte=${current_date_str.split('T')[0]}';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['results'];
        data.forEach((json) {
          final movie = Movie.fromJson(json);
          upcomingMoviesMap[movie.id] = movie;
        });
        return upcomingMoviesMap.values.toList();
      } else {
        throw Exception('Failed to load upcoming movies');
      }
    } catch (e) {
      throw Exception('Error fetching upcoming movies: $e');
    }
  }

  // top rated movies 
  static Future<List<Movie>> _fetchTopRatedMovies() async {
    final Map<int, Movie>  topRatedMoviesMap = {};
    const apiKey = Constants.API_key;
    final apiUrl = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['results'];
        data.forEach((json) {
          final movie = Movie.fromJson(json);
          topRatedMoviesMap[movie.id] = movie;
        });
        return topRatedMoviesMap.values.toList();
      } else {
        throw Exception('Failed to load upcoming movies');
      }
    } catch (e) {
      throw Exception('Error fetching upcoming movies: $e');
    }
  }
}

