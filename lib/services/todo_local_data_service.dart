import 'package:simplytodo/core/service/sqlite_service.dart';
import 'package:sqflite/sqflite.dart';

final class TodoLocalDataService {
  late final Database _db;

  TodoLocalDataService({
    Database? db,
  }) : _db = SqliteService().db;

  Future<int> saveTodo(Map<String, dynamic> json) => _db.insert(
        "todos",
        json,
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );

  Future<Iterable<int>> saveTodos(Iterable<Map<String, dynamic>> jsonIter) =>
      _db.transaction((txn) async {
        final batch = txn.batch();
        for (var json in jsonIter) {
          batch.insert(
            "todos",
            json,
            conflictAlgorithm: ConflictAlgorithm.rollback,
          );
        }

        return await batch.commit() as List<int>;
      });

  Future<Iterable<Map<String, dynamic>>> getTodoList() async {
    final List<Map<String, dynamic>> jsonIter = await _db.query("todos");
    return jsonIter;
  }

  Future<Map<String, dynamic>> getTodo(int id) async {
    final List<Map<String, dynamic>> dataIter = await _db.query(
      "todos",
      where: '"id" = ?',
      whereArgs: [id],
    );

    final Map<String, dynamic> json = switch (dataIter.length) {
      0 => throw Exception("There is no matching data"),
      1 => dataIter.first,
      _ => throw Exception("There are multiple matching data"),
    };

    return json;
  }

  Future<int> updateTodo(Map<String, dynamic> json) => _db.update(
        "todos",
        json,
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );

  Future<void> deleteTodo(int id) => _db.delete(
        "todos",
        where: '"id" = ?',
        whereArgs: [id],
      );

  Future<void> clearTodoTable() => _db.delete("todos");
}
