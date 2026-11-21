import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'cobranca_facil.db';
  static const _databaseVersion = 1;

  DatabaseHelper._();

  static final DatabaseHelper instance =
      DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(
      await getDatabasesPath(),
      _databaseName,
    );

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {

    await db.execute('''
      CREATE TABLE templates(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        conteudo TEXT NOT NULL,
        criado_em TEXT NOT NULL,
        atualizado_em TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE settings(
        id INTEGER PRIMARY KEY,
        nome_analista TEXT
      )
    ''');

    await db.insert(
      'settings',
      {
        'id': 1,
        'nome_analista': '',
      },
    );
  }
}