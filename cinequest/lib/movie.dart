import 'dart:convert';
import 'package:flutter/material.dart';
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

  Movie(this. movie_title, this.movie_image, this.movie_image_path, this.movie_original_title, this.movie_synopsis, this.movie_release_date, this.movie_vote_avg, this.id);

  factory Movie.fromJson(Map<String, dynamic> json) {

  return Movie(
    json['title'] as String,
    json['backdrop_path'] as String,
    json['poster_path'] as String,
    json['original_title'] as String,
    json['overview'] as String,
    json['release_date'] as String,
    json['vote_average'] as double,
    json['id'] as int
  );
}

}