import 'package:simpletodo/domain/model/todo_model.dart';

interface class TodoRepository {
  Future<void> saveTodoList(List<Todo> todos) async {
    throw UnimplementedError();
  }

  Future<List<Todo>> getTodoList() async {
    throw UnimplementedError();
  }
}
