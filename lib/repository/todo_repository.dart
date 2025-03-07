import 'dart:convert';
import 'package:simplytodo/common/enums.dart';
import 'package:simplytodo/services/shared_preference_service.dart';

import '../model/todo_model.dart';

part 'todo_repository_impl.dart';

abstract interface class TodoRepository {
  Future<void> saveTodoList(List<TodoModel> todos);

  Future<void> saveTodo(TodoModel todo);

  Future<List<TodoModel>> getTodoList();

  Future<void> deleteTodo(int id);

  Future<void> clearTodoList();
}
