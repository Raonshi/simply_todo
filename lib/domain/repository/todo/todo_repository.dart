import 'package:simpletodo/domain/model/todo_model.dart';

interface class TodoRepository {
  Future<void> saveTodoList(List<Todo> todos) async {
    throw UnimplementedError();
  }

  Future<void> saveTodo(Todo todo) async {}

  Future<List<Todo>> getTodoList() async {
    throw UnimplementedError();
  }

  Future<void> deleteTodo(int id) async {}

  Future<void> clearTodoList() async {}

}
