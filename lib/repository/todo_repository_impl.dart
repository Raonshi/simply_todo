part of 'todo_repository.dart';

final class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<List<TodoModel>> getTodoList() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<String> dataList =
        pref.getStringList(LocalStorageKeys.todoList.str) ?? [];

    return dataList.map((e) => TodoModel.fromJson(jsonDecode(e))).toList();
  }

  @override
  Future<void> saveTodoList(List<TodoModel> todos) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<String> dataList =
        todos.map((e) => jsonEncode(e.toJson())).toList();

    await pref.setStringList(LocalStorageKeys.todoList.str, dataList);
  }

  @override
  Future<void> clearTodoList() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(LocalStorageKeys.todoList.str);
  }

  @override
  Future<void> deleteTodo(int id) async {
    final List<TodoModel> todos = await getTodoList();
    final List<TodoModel> newTodos = todos.where((e) => e.id != id).toList();
    await saveTodoList(newTodos);
  }

  @override
  Future<void> saveTodo(TodoModel todo) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<TodoModel> todos = await getTodoList();
    final int idx = todos.indexWhere((e) => e.id == todo.id);
    if (idx == -1) {
      todos.add(todo);
    } else {
      todos[idx] = todo;
    }

    final List<String> dataList =
        todos.map((e) => jsonEncode(e.toJson())).toList();
    await pref.setStringList(LocalStorageKeys.todoList.str, dataList);
  }
}
