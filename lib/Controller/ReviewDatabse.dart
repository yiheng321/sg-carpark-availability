import 'dart:async';
import 'dart:io';
import 'package:sg_carpark_availability/Entity/Review.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class ReviewDataBase {
  static Database ? _db;
  static const String id = 'id';
  static const String carParkNo = 'carParkNo';
  static const String address = 'address';
  static const String cost = 'cost';
  static const String convenience = 'convenience';
  static const String security = 'security';
  static const String numOfReviewCost = 'numOfReviewCost';
  static const String numOfReviewConvenience = 'numOfReviewConvenience';
  static const String numOfReviewSecurity = 'numOfReviewSecurity';
  static const String TABLE = 'Review';
  static const String DB_NAME = 'Review.db';
  static bool initialized = false;

  Future<Database> get db async {
    return _db !;
      _db = await initDb();
    return _db !;
  }

  initDb() async {
    // Construct a file path to copy database to
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "review_db.db");

    // Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', DB_NAME));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Save copied asset to documents
      await File(path).writeAsBytes(bytes);
    }
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'review_db.db');
    var db = await openDatabase(databasePath, version: 1);
    initialized = true;
    return db;
  }

  Future<List<Review>> getAllReview() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Review> reviews = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        reviews.add(Review.fromMap(maps[i] as Map<String, dynamic>));
      }
    }
    return reviews;
  }

  Future<Review?> getSingaleReviewbyCarparkNo(String carparkNumber) async {
    var dbClient = await db;
    List<Map> maps = await dbClient
        .rawQuery("SELECT * FROM $TABLE where $carParkNo = ?", [carparkNumber]);
    Review ? review;
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        review = Review.fromMap(maps[i] as Map<String, dynamic>);
        break;
      }
    }
    return review;
  }

  Future<int> deleteReviewById(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$id = ?', whereArgs: [id]);
  }

  Future<int> updateReviewById(Review review) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, review.toMap(),
        where: '$id = ?', whereArgs: [review.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
