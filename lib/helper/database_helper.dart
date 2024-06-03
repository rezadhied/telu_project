import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'teluproject.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'teluproject.db');
    databaseFactory.deleteDatabase(path);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      userID TEXT PRIMARY KEY,
      firstName TEXT,
      lastName TEXT,
      email TEXT UNIQUE,
      gender TEXT,
      lectureCode TEXT,
      facultyCode TEXT,
      majorCode TEXT,
      kelas TEXT,
      phoneNumber TEXT,
      photoProfileImage TEXT,
      photoProfileUrl TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE Project (
      projectID INTEGER PRIMARY KEY,
      title TEXT,
      projectOwnerID TEXT,
      description TEXT,
      startProject TEXT,
      endProject TEXT,
      openUntil TEXT,
      totalMember INTEGER,
      groupLink TEXT,
      projectStatus TEXT CHECK(projectStatus IN ('Open Request', 'Waiting to Start', 'Active', 'Finished')),
      createdAt TEXT,
      FOREIGN KEY (projectOwnerID) REFERENCES users (userID) ON DELETE NO ACTION ON UPDATE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE ProjectMember (
      projectMemberID INTEGER PRIMARY KEY,
      userID TEXT,
      roleID INTEGER,
      projectID INTEGER,
      FOREIGN KEY (userID) REFERENCES users (userID) ON DELETE NO ACTION ON UPDATE CASCADE,
      FOREIGN KEY (roleID) REFERENCES Role (roleID) ON DELETE NO ACTION ON UPDATE CASCADE,
      FOREIGN KEY (projectID) REFERENCES Project (projectID) ON DELETE CASCADE ON UPDATE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE ProjectRole (
      roleID INTEGER,
      quantity INTEGER,
      projectID INTEGER,
      FOREIGN KEY (projectID) REFERENCES Project (projectID) ON DELETE CASCADE ON UPDATE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE ProjectSkill (
      projectID INTEGER,
      skillID INTEGER,
      FOREIGN KEY (projectID) REFERENCES Project (projectID) ON DELETE CASCADE ON UPDATE CASCADE
    )
    ''');

    await db.execute('''
    CREATE TABLE Skill (
      skillID INTEGER PRIMARY KEY,
      name TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE Role (
      roleID INTEGER PRIMARY KEY,
      name TEXT
    )
    ''');
  }
}
