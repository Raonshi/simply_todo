import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpletodo/common/enums.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<List<Todo>> getTodoList() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<String> dataList =
        pref.getStringList(LocalStorageKeys.todoList.str) ?? [];

    return dataList.map((e) => Todo.fromJson(jsonDecode(e))).toList();
  }

  @override
  Future<void> saveTodoList(List<Todo> todos) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<String> dataList =
        todos.map((e) => jsonEncode(e.toMap())).toList();

    await pref.setStringList(LocalStorageKeys.todoList.str, dataList);
  }
}
