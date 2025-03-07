import 'package:simplytodo/common/tools.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static final SqliteService _instance = SqliteService._internal();
  factory SqliteService() => _instance;
  SqliteService._internal();

  late final Database _db;
  Database get db => _db;

  bool initialized = false;

  Future<void> init() async {
    _db = await openDatabase(
      "simply_todo_db.db",
      version: 1,
      onCreate: _onCreate,
    );

    lgr.d(
        "SqliteService initialized\n\n >>> DB Opened : ${_db.isOpen}\n\n >>> DB Path : ${_db.path}");
  }

  void _onCreate(Database db, int version) async {
    await _createTodoTable(db);
    initialized = true;
  }

  Future<void> _createTodoTable(Database db) => db.transaction((txn) async {
        await txn.execute("CREATE TABLE todos ("
            "id INTEGER PRIMARY KEY, title TEXT, content TEXT, "
            "due_date INTEGER, start_date INTEGER, end_date INTEGER, "
            "show_notification INTEGER, completed INTEGER)");
      });
}
