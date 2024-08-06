import 'package:simpletodo/domain/model/todo_model.dart';

interface class TodoRepository {
  Future<void> saveTodoList(List<TodoModel> todos) async {
    throw UnimplementedError();
  }

  Future<void> saveTodo(TodoModel todo) async {}

  Future<List<TodoModel>> getTodoList() async {
    throw UnimplementedError();
  }

  Future<void> deleteTodo(int id) async {}

  Future<void> clearTodoList() async {}
}
