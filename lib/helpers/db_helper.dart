import 'dart:developer';

import 'package:db_demo_app/models/stud_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper dbHelper = DbHelper._();

  late Database database;
  String query = "";

  String studTable = "Student";
  String colId = "id";
  String colName = "name";
  String colAge = "age";

  Future<void> initDb() async {
    String dbPath = await getDatabasesPath();
    String dbName = "MyDatabase.db";
    String path = join(dbPath + dbName);

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, ver) {
        query =
            "CREATE TABLE IF NOT EXISTS $studTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT,$colAge INTEGER)";

        db
            .execute(query)
            .then((value) => log("$studTable created...."))
            .onError((error, stackTrace) => log("ERROR: $error"));
      },
    );
  }

  Future<void> insert({required Student student}) async {
    Map<String, dynamic> data = student.toMap;
    data.remove('id');
    await database
        .insert(studTable, data)
        .then((value) => log("Inserted...."))
        .onError((error, stackTrace) => log("ERROR: $error"));
  }

  Future<void> update({required Student student}) async {
    await database
        .update(studTable, student.toMap)
        .then((value) => log("Updated...."))
        .onError((error, stackTrace) => log("ERROR: $error"));
  }

  Future<void> delete({required Student student}) async {
    await database
        .delete(studTable, where: "id = ${student.id}")
        .then((value) => log("Updated...."))
        .onError((error, stackTrace) => log("ERROR: $error"));
  }

  Future<List<Student>> getData() async {
    query = "SELECT * FROM $studTable";

    List<Map> allData = await database.rawQuery(query);

    return allData
        .map(
          (e) => Student.fromMap(data: e),
        )
        .toList();
  }
}
