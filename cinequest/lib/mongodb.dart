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
}
