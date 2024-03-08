import 'package:cinequest/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cinequest/movie_model.dart';
import 'package:cinequest/constants.dart';
import 'package:provider/provider.dart';

class SavedMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesListModel = Provider.of<MovieModel>(context);
    final savedMovies = moviesListModel.savedMovies;

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
      body: savedMovies.isNotEmpty
          ? ListView.builder(
              itemCount: savedMovies.length,
              itemBuilder: (context, index) {
                final savedMovie = savedMovies[index];
                return ListTile(
                  title: Text(savedMovie.movie_title),
                  leading: Image.network(
                    '${Constants.image_path}${savedMovie.movie_image_path}',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  onTap: () {
                    // Handle tapping on saved movie
                  },
                );
              },
            )
          : Center(
              child: Text(
                "No saved movies",
                style: TextStyle(fontSize: 20),
              ),
            ),
      drawer: AppDrawer(),
    );
  }
}

