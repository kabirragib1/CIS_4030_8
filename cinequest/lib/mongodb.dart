import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'constant.dart';

class MongoDatabase {
  static Db? db;

  static Future<void> connect() async {
    db = await Db.create(MONGO_URL);
    await db?.open();
    inspect(db);
  }

  static Future<void> insertUser(Map<String, dynamic> userData) async {
    var collection = db?.collection(COLLECTION_NAME);
    await collection?.insertOne(userData);
  }

  static Future<Map<String, dynamic>?> findUserByEmail(String email) async {
    var collection = db?.collection(COLLECTION_NAME);
    final user = await collection?.findOne(where.eq('email', email));
    return user;
  }

  // Add a movie to the user's favorites
  static Future<void> addFavoriteMovie(String userEmail, Map<String, dynamic> movieData) async {
    var collection = db?.collection(FAVORITES_COLLECTION_NAME);
    // Include user email to identify the user who saved the movie
    final document = {'userEmail': userEmail, ...movieData};
    await collection?.insertOne(document);
  }

  // Retrieve all favorite movies for a user
  static Future<List<Map<String, dynamic>>> getFavoriteMovies(String userEmail) async {
    var collection = db?.collection(FAVORITES_COLLECTION_NAME);
    final movies = await collection?.find(where.eq('userEmail', userEmail)).toList();
    return movies ?? [];
  }


  // Method to remove a movie from a user's favorites
  static Future<void> removeFavoriteMovie(String userEmail, int movieId) async {
    var collection = db?.collection(FAVORITES_COLLECTION_NAME);
    await collection?.deleteOne({'userEmail': userEmail, 'movieId': movieId});
  }

}
