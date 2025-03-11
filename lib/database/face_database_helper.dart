import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FaceDatabaseHelper {
  static final FaceDatabaseHelper _instance = FaceDatabaseHelper._internal();
  factory FaceDatabaseHelper() => _instance;
  static Database? _database;

  FaceDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'face_attendance.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER,
        workType TEXT,
        employeeId TEXT,
        faceData TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE attendance(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        date TEXT,
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    await db.insert('users', user);
  }

  Future<void> insertMultipleUsers(List<Map<String, dynamic>> users) async {
    Database db = await database;
    Batch batch = db.batch();
    for (var user in users) {
      batch.insert('users', user);
    }
    await batch.commit();
  }

  Future<void> markAttendance(Map<String, dynamic> attendance) async {
    Database db = await database;
    await db.insert('attendance', attendance);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await database;
    return await db.query('users');
  }

  Future<List<Map<String, dynamic>>> getAttendance() async {
    Database db = await database;
    return await db.query('attendance');
  }
}
