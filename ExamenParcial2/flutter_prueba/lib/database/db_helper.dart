import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static const _dbName = 'galeria.db';
  static const _dbVersion = 1;

  static Future<Database> database() async {
    final path = join(await getDatabasesPath(), _dbName);

    return openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE galeria (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        autor TEXT NOT NULL
      )
    ''');

    // Cargar datos de ejemplo
    for (int i = 1; i <= 15; i++) {
      await db.insert('galeria', {
        'titulo': 'Imagen $i',
        'imageUrl': 'https://picsum.photos/seed/galeria$i/300/200',
        'autor': 'SST-7',
      });
    }
  }

  static Future<List<Map<String, dynamic>>> getByAutor(String autor) async {
    final db = await database();
    return db.query('galeria', where: 'autor = ?', whereArgs: [autor]);
  }
}
