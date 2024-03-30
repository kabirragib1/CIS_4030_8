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

  static Future<bool> checkUserExistsByUsername(String username) async {
    var collection = db?.collection(COLLECTION_NAME);
    final result = await collection?.findOne(where.eq('username', username));
    return result != null; // Returns true if a user exists with the given username
  }

  static Future<bool> checkUserExistsByEmail(String email) async {
    var collection = db?.collection(COLLECTION_NAME);
    final result = await collection?.findOne(where.eq('email', email));
    return result != null; // Returns true if a user exists with the given email
  }

  static Future<Map<String, dynamic>?> findUserByEmail(String email) async {
    var collection = db?.collection(COLLECTION_NAME);
    final user = await collection?.findOne(where.eq('email', email));
    return user;
  }

  // Method to add a favorite movie by movie ID
  static Future<void> addFavoriteMovieById(String userEmail, int movieId) async {
    var collection = db?.collection(FAVORITES_COLLECTION_NAME);
    final document = {
      'userEmail': userEmail,
      'movieId': movieId
    };
    await collection?.insertOne(document);
  }

// Method to add a favorite movie by movie data
  static Future<void> addFavoriteMovieByData(String userEmail, Map<String, dynamic> movieData) async {
    var collection = db?.collection(FAVORITES_COLLECTION_NAME);
    final document = {
      'userEmail': userEmail,
      ...movieData
    };
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

  static Future<void> removeFavoriteMovieByData(String userEmail, Map<String, dynamic> movieData) async {
    var collection = db?.collection(FAVORITES_COLLECTION_NAME);
    final document = {
      'userEmail': userEmail,
      ...movieData
    };
    await collection?.deleteOne(document);
  }

  static Future<bool> updateUserPassword(String email, String username, String newPassword) async {
    var collection = db?.collection(COLLECTION_NAME);
    // First, check if a user with the given email and username exists
    final user = await collection?.findOne(where.eq('email', email).eq('username', username));
    if (user != null) {
      // If the user exists, update the password
      await collection?.updateOne(where.id(user['_id']), modify.set('password', newPassword));
      return true; // Return true to indicate success
    }
    return false; // Return false if no user was found
  }


}