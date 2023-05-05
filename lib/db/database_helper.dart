import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/student.dart';

class DatabaseHelper {
  // database
  DatabaseHelper._privateConstructor(); // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database

    Directory directory = await getApplicationDocumentsDirectory();

    String path = '${directory.path}/students.db';

    // open/ create database at a given path
    var studentsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return studentsDatabase;
  } // end of function

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE tbl_students (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  name TEXT,
                  regno INTEGER )
                  ''');

    // await db.execute('''Create TABLE tbl_courses (
    //               id INTEGER PRIMARY KEY AUTOINCREMENT,
    //               name TEXT,
    //               regno INTEGER )
    //               ''');
  } // e// nd of func

  Future<int> insertStudent(Student std) async {
    Database db = await instance.database;
    int result = await db.insert('tbl_students', std.toMap());
    return result;
  } // end of insertStudent

  Future<int> deleteStudent(Student std) async {
    Database db = await instance.database;
    int result = await db.delete('tbl_students', where: 'regno=?', whereArgs: [std.regno]);
    return result;
  }

  Future<int> updateStudent(Student std) async {
    Database db = await instance.database;
    int result = await db.update('tbl_students', std.toMap(), where: 'id=?',
                      whereArgs: [std.id]);
    return result;
  }

  Future<List<Student>> getAllStudents() async {

    List<Student> students = [];

    Database db = await instance.database;

    // read data from table
    List<Map<String, dynamic>> listMap = await db.query('tbl_students');

    for (var stdMap in listMap) {
      Student std = Student.fromMap(stdMap);
      students.add(std);
    }

    return students;

  }

  } // end of class DatabaseHelper