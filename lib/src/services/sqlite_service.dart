import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:utilidades/src/models/person_model.dart';

class SqliteService {
  static final SqliteService _instance = SqliteService._internal();
  factory SqliteService() => _instance;
  SqliteService._internal(); // controla o fluxo de criação do banco de dados

  static Database? _db;

  Future<Database> get db async {
    _db ??= await _initDB("app.db");
    return _db!;
  }

  Future<Database> _initDB(String name) async {
    final path = join(await getDatabasesPath(), name);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE pessoas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        idade INTEGER NOT NULL
      )
    """);
  }

  Future<int> insertPerson(PersonModel person) async {
    final database = await db;
    return database.insert("pessoas", person.toMap());
  }

  Future<List<PersonModel>> getAllPersons() async {
    final database = await db;
    final result = await database.query("pessoas");
    return result.map((e) => PersonModel.fromMap(e)).toList();
  }

  Future<void> deletePerson(int id) async {
    final database = await db;
    // o valor de whereArgs é passado para o caracter "?" do where
    await database.delete("pessoas", where: "id = ?", whereArgs: [id]);
  }
}
