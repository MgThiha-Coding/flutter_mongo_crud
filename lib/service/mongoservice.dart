import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongoo/constant/constant.dart';
import 'package:mongoo/service/model/mongomodel.dart';

class Mongoservice {
  static late Db db;
  static late DbCollection userCollection;
  static Future<void> connect() async {
    try {
      db = await Db.create(mongo_url);
      await db.open();
      if (db.isConnected) {
        print("Database connected successfully!");
        inspect(db);
        userCollection = db.collection(collection);
      } else {
        print("Failed to connect to the database.");
      }
    } catch (e) {
      print("Error while connecting to the database: $e");
    }
  }

  static Future<void> insert(Mongomodel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        print("Data inserted successfully!");
      } else {
        print("Error: Failed to insert data.");
      }
    } catch (e) {
      print("Error while inserting data: $e");
    }
  }

  static Future<List<Mongomodel>> getData() async {
    try {
      var result = await userCollection.find().toList();
      return result.map((e) => Mongomodel.fromJson(e)).toList();
    } catch (e) {
      print("Error while fetching data: $e");
      return [];
    }
  }

  static Future<String> deleteData(ObjectId id) async {
    try {
      var result = await userCollection.remove(where.id(id));
      if (result['n'] > 0) {
        return "Data deleted successfully!";
      } else {
        return "Error: No data found to delete.";
      }
    } catch (e) {
      return "Error while deleting data: $e";
    }
  }

  static Future<void> update(Mongomodel data) async {
    try {
      await userCollection.updateOne(
        {"_id": data.id},
        {
          "\$set": {
            "firstName": data.firstName,
            "lastName": data.lastName,
            "address": data.address
          }
        },
      );
      print("Data updated successfully!");
    } catch (e) {
      print("Error while updating data: $e");
    }
  }
}
