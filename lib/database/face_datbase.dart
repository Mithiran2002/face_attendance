import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FaceDatabase {
  static final FaceDatabase _instance = FaceDatabase._internal();
  static Database? _database;

  factory FaceDatabase() {
    return _instance;
  }

  FaceDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'faces.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE faces(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        age INTEGER,
        embedding TEXT
      )
    ''');
  }

  Future<int> insertFace(Map<String, dynamic> face) async {
    final db = await database;
    return await db.insert('faces', face);
  }

  Future<List<Map<String, dynamic>>> getFaces() async {
    final db = await database;
    return await db.query('faces');
  }
}