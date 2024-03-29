import 'package:cinequest/constants.dart';
import 'package:cinequest/movie_cast.dart';
import 'package:cinequest/movie_company.dart';
import 'package:cinequest/movie_crew.dart';
import 'package:cinequest/movie_genre.dart';
import 'package:cinequest/view_reviews.dart';
import 'package:cinequest/movie_availability.dart';
import 'package:cinequest/watch_movie.dart';
import 'package:flutter/material.dart';
import 'package:cinequest/movie_interact.dart';
import 'package:cinequest/movie_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cinequest/movie.dart';
import 'mongodb.dart';

class MoviePage extends StatefulWidget {

  final String movie_image_path;
  final String movie_title;
  final String movie_synopsis;
  final String movie_release_date;
  final double movie_vote_avg;
  final int movieId;
  final String? userEmail;

  MoviePage({required this.movie_image_path, required this.movie_title, required this.movie_synopsis, required this.movie_release_date, required this.movie_vote_avg, required this.movieId, this.userEmail,});


  @override
  _MoviePageState createState() => _MoviePageState();

}

class _MoviePageState extends State<MoviePage> {

  List <MovieAvailability> film_availability = [];
  List <MovieCast> film_cast = [];
  List <MovieGenre> film_genres = [];
  List <MovieCrew> film_crew = [];
  bool film_crew_loaded = false;
  List <MovieCompany> film_companies = [];

  @override
  void initState() {
    super.initState();
    fetch_movie_availability(widget.movieId);
    fetch_movie_cast(widget.movieId);
    fetch_movie_genres(widget.movieId);
    fetch_movie_companies(widget.movieId);
    fetch_movie_crew(widget.movieId);
  }

  Future<void> fetch_movie_availability(int movieId) async {
    final api_data = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/${movieId}/watch/providers?api_key=${Constants.API_key}'));
    if (api_data.statusCode != 200) {
        setState(() {
          film_availability = [];
        });
    } else {
      final api_json = jsonDecode(api_data.body)['results'] as Map<String, dynamic>;
      if (api_json.isNotEmpty) {
        bool flat_rate_indicator = false;
        api_json.forEach((country_code, watch_data) {
          if (watch_data.containsKey('flatrate')) {
            if (watch_data['flatrate'] is List) {
              film_availability.add(MovieAvailability.fromJson(movieId, country_code, watch_data));
              flat_rate_indicator = true;
            }
          }
        });
        if (flat_rate_indicator == false) {
          setState(() {
            film_availability = [];
          });
        } else { 
          setState(() {
            film_availability = film_availability;
          });
        }
      } else {
        setState(() {
          film_availability = [];
        });
      }
    }
  }

  Future<void> fetch_movie_cast(int movieId) async {
     final api_data = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/${movieId}/credits?api_key=${Constants.API_key}'));
      if (api_data.statusCode != 200) {
        setState(() {
          film_cast = [];
        });
    } else {
      final api_json = jsonDecode(api_data.body)['cast'] as List;
      film_cast = api_json.map((cast) => MovieCast.fromJson(cast)).toList();
      setState(() {
        film_cast = film_cast;
      });
    }
  }

    Future<void> fetch_movie_genres(int movieId) async {
     final api_data = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/${movieId}?api_key=${Constants.API_key}'));
      if (api_data.statusCode != 200) {
        setState(() {
          film_genres = [];
        });
    } else {
      final api_json = jsonDecode(api_data.body)['genres'] as List;
      film_genres = api_json.map((cast) => MovieGenre.fromJson(cast)).toList();
      setState(() {
        film_genres = film_genres;
      });
    }
  }

  Future<void> fetch_movie_companies(int movieId) async {
    final api_data = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/${movieId}?api_key=${Constants.API_key}'));
      if (api_data.statusCode != 200) {
        setState(() {
          film_companies = [];
        });
    } else {
      final api_json = jsonDecode(api_data.body)['production_companies'] as List;
      film_companies = api_json.map((company) => MovieCompany.fromJson(company)).toList();
      setState(() {
        film_companies = film_companies;
      });
    }
  }

  Future<void> fetch_movie_crew(int movieId) async {
    final api_data = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/${movieId}/credits?api_key=${Constants.API_key}'));
      if (api_data.statusCode != 200) {
        setState(() {
          film_crew = [];
          film_crew_loaded = false;
        });
    } else {
      final api_json = jsonDecode(api_data.body)['crew'] as List;
      film_crew = api_json.map((crew) => MovieCrew.fromJson(crew)).toList();
      setState(() {
        film_crew = film_crew;
        film_crew_loaded = true;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final moviesListModel = Provider.of<MovieModel>(context);
    final movie_watch_country_data = moviesListModel.get_all_countries;
    final saved_movies = moviesListModel.get_savedMovies;

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
        centerTitle: true,
      ),
      body: film_crew_loaded
      ? ListView(
        children: [
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 300,
                            width: 200,
                            child: Image.network(
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                                '${Constants.image_path}${widget.movie_image_path}'
                            )
                        ),
                        Flexible(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Movie Title: ',
                                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      widget.movie_title,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    const SizedBox(height: 25),
                                    const Text(
                                      'Director: ',
                                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      film_crew.indexWhere((crew) => crew.job == ('Director')) >= 0 
                                      ? film_crew[film_crew.indexWhere((crew) => crew.job == ('Director'))].name
                                      : 'TBD',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    const SizedBox(height: 25),
                                    const Text(
                                      'Release Date: ',
                                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      widget.movie_release_date,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    // Text('Duration: ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                    // SizedBox(height: 25),
                                    // Text('Studio: ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                    // SizedBox(height: 25),
                                    // Text('Box Office: ', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                                  ]
                              ),
                            )
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 3.0,
                      indent: 10.0,
                      endIndent: 10.0,
                      color: Colors.white,
                      height: 15.0,
                    ),
                    const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child:  Text('SYNOPSIS:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          )
                        ]
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(widget.movie_synopsis, softWrap: true, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 3.0,
                      indent: 10.0,
                      endIndent: 10.0,
                      color: Colors.white,
                      height: 15.0,
                    ),
                    const Row (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child:  Text('PRODUCTION COMPANIES:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container( 
                          height: 150, 
                          // color:  Color.fromARGB(255, 144, 90, 10),
                          child: ListView.builder(
                            itemCount: film_companies.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(12.0),
                                color:  Color.fromARGB(255, 144, 90, 10),
                                child: ListTile(
                                  leading: 
                                  film_companies[index].logo_path != '' ?
                                  Container (
                                    width: 200,
                                    height: 200,
                                    padding: EdgeInsets.all(10.0),
                                    child: Image.network(
                                      filterQuality: FilterQuality.high,
                                      '${Constants.image_path}${film_companies[index].logo_path}',
                                      fit: BoxFit.contain,
                                    )
                                  )
                                  : Icon(Icons.circle, size: 15.0),
                                  title: Text('${film_companies[index].name}', softWrap: true, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal))
                                )
                              );
                            }
                          )
                        )
                      ]
                    ),
                    const Divider(
                      thickness: 3.0,
                      indent: 10.0,
                      endIndent: 10.0,
                      color: Colors.white,
                      height: 15.0,
                    ),
                     const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child:  Text('CAST:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          )
                        ]
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container( 
                          height: 250, 
                          child: ListView.builder(
                            itemCount: film_cast.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(Icons.circle, size: 15.0),
                                title: film_cast[index].character == ""  
                                ? Text('${film_cast[index].name}', softWrap: true, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal))
                                : Text('${film_cast[index].name} as ${film_cast[index].character}', softWrap: true, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal))
                              );
                            },
                          )
                        )
                      ]
                    ),
                    const Divider(
                      thickness: 3.0,
                      indent: 10.0,
                      endIndent: 10.0,
                      color: Colors.white,
                      height: 15.0,
                    ),
                    const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child:  Text('GENRES:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          )
                        ]
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container( 
                          height: 100, 
                          child: ListView.builder(
                            itemCount: film_genres.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(Icons.circle, size: 15.0),
                                title: Text('${film_genres[index].name}', softWrap: true, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal))
                              );
                            },
                          )
                        )
                      ]
                    ),
                    const Divider(
                      thickness: 3.0,
                      indent: 10.0,
                      endIndent: 10.0,
                      color: Colors.white,
                      height: 15.0,
                    ),
                    const Row (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child:  Text('WHERE TO WATCH:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    film_availability.isNotEmpty
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container( 
                          height: 250, 
                          child: ListView.builder(
                            itemCount: film_availability.length,
                            shrinkWrap: true,
                            itemBuilder: (context, country_index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  movie_watch_country_data.indexWhere((country) => country.country_short_form == (film_availability[country_index].country_short_form)) >= 0
                                  ? Text(movie_watch_country_data[movie_watch_country_data.indexWhere((country) => country.country_short_form == (film_availability[country_index].country_short_form))].english_name, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal))
                                  : Text(film_availability[country_index].country_short_form, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: film_availability[country_index].streaming_services.length,
                                    itemBuilder: (context, streaming_service_index) {
                                      return Container(
                                        margin: EdgeInsets.all(12.0),
                                        color:  Color.fromARGB(255, 144, 90, 10),
                                        child:  ListTile(
                                          title: Text(film_availability[country_index].streaming_services[streaming_service_index].provider_name),
                                          leading: Image.network(
                                            height: 75,
                                            width: 50,
                                            filterQuality: FilterQuality.high,
                                            '${Constants.image_path}${film_availability[country_index].streaming_services[streaming_service_index].logo_path}',
                                            fit: BoxFit.cover,
                                          ),
                                          onTap: () {}
                                        ) ,
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 25)
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    )
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded( // Ensure the text takes available space
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Currently No Streaming Service Has ${widget.movie_title} Available. Please Visit Your Local Theatre.', softWrap: true, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 3.0,
                      indent: 10.0,
                      endIndent: 10.0,
                      color: Colors.white,
                      height: 15.0,
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>  ViewReviewPage(movie_image_path: widget.movie_image_path, movie_title: widget.movie_title, movie_vote_avg: widget.movie_vote_avg, movieId: widget.movieId)));
                      },
                      child: const Text('VIEW REVIEWS', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 250, 178, 54),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                      )
                    ),
                    const SizedBox(height: 15),
                    saved_movies.indexWhere((movie) => movie.id == widget.movieId) < 0 
                    ? ElevatedButton(
                      onPressed: () {
                        final movie = Movie(
                          widget.movie_title,
                          '',
                          widget.movie_image_path,
                          '',
                          widget.movie_synopsis,
                          widget.movie_release_date,
                          widget.movie_vote_avg,
                          widget.movieId
                        );
                        Provider.of<MovieModel>(context, listen: false).toggleFavorite(context, movie);
                      },
                      child: Text(
                        'SAVE MOVIE',
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 250, 178, 54),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                      ),
                    ) 
                    : ElevatedButton(
                      onPressed: () {
                        final movie = Movie(
                          widget.movie_title,
                          '',
                          widget.movie_image_path,
                          '',
                          widget.movie_synopsis,
                          widget.movie_release_date,
                          widget.movie_vote_avg,
                          widget.movieId
                        );
                        Provider.of<MovieModel>(context, listen: false).toggleFavorite(context, movie);
                      },
                      child: Text(
                        'UNLIKE MOVIE',
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 250, 178, 54),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                      ),
                    ),
                    const SizedBox(height: 15),
                    // const SizedBox(height: 15),
                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       ElevatedButton(
                    //           onPressed: (){
                    //             Navigator.push(context,MaterialPageRoute(builder: (context) =>  WatchMoviePage()));
                    //           },
                    //           child: Text('WATCH', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                    //           style: ElevatedButton.styleFrom(
                    //             primary: Color.fromARGB(255, 250, 178, 54),
                    //             onPrimary: Colors.white,
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(50), // Rounded corners
                    //             ),
                    //             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                    //           )
                    //       ),
                    //       const SizedBox(width: 15),
                    //       ElevatedButton(
                    //           onPressed: (){
                    //             Navigator.push(context,MaterialPageRoute(builder: (context) =>  MovieInteract(movie_image_path: movie_image_path, movie_title: movie_title, movie_vote_avg: movie_vote_avg)));
                    //           },
                    //           child: Text('INTERACT', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                    //           style: ElevatedButton.styleFrom(
                    //             primary: Color.fromARGB(255, 250, 178, 54),
                    //             onPrimary: Colors.white,
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(50), // Rounded corners
                    //             ),
                    //             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
                    //           )
                    //       ),
                    //     ]
                    // )
                  ]
              )
          ),
        ],
      )
      : const Center(
        child: CircularProgressIndicator()
      )
      // drawer: AppDrawer()
    );
  }
}
