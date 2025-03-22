import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductDatabase {
  static final ProductDatabase _instance = ProductDatabase._internal();
  factory ProductDatabase() => _instance;
  ProductDatabase._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Creación de la tabla "products"
    await db.execute('''
      CREATE TABLE products(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        aprobed TEXT,
        images TEXT
      )
    ''');
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
