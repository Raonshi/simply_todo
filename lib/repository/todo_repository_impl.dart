part of 'todo_repository.dart';

final class TodoRepositoryImpl implements TodoRepository {
  final SharedPreferenceService Function() _localServiceFactory;

  const TodoRepositoryImpl({
    SharedPreferenceService Function()? localServiceFactory,
  }) : _localServiceFactory =
            localServiceFactory ?? SharedPreferenceService.new;

  @override
  Future<List<TodoModel>> getTodoList() =>
      _localServiceFactory().getStringList(LocalStorageKeys.todoList.str).then(
        (dataIter) {
          if (dataIter == null) return [];
          return dataIter
              .map((e) => TodoModel.fromJson(jsonDecode(e)))
              .toList();
        },
      );

  @override
  Future<void> saveTodoList(List<TodoModel> todos) =>
      _localServiceFactory().saveList(
        key: LocalStorageKeys.todoList.str,
        valueIter: todos.map((e) => jsonEncode(e.toJson())).toList(),
      );

  @override
  Future<void> clearTodoList() =>
      _localServiceFactory().remove(LocalStorageKeys.todoList.str);

  @override
  Future<void> deleteTodo(int id) async {
    final List<TodoModel> todos = await getTodoList();
    final List<TodoModel> newTodos = todos.where((e) => e.id != id).toList();
    await saveTodoList(newTodos);
  }

  @override
  Future<void> saveTodo(TodoModel todo) async {
    final SharedPreferenceService localService = _localServiceFactory();
    final List<TodoModel> prevTodos = await localService
        .getStringList(LocalStorageKeys.todoList.str)
        .then((dateIter) {
      if (dateIter == null) return [];
      return dateIter.map((e) => TodoModel.fromJson(jsonDecode(e))).toList();
    });

    final int idx = prevTodos.indexWhere((e) => e.id == todo.id);
    if (idx == -1) {
      prevTodos.add(todo);
    } else {
      prevTodos[idx] = todo;
    }

    final List<String> dataList =
        prevTodos.map((e) => jsonEncode(e.toJson())).toList();

    await localService.saveList(
      key: LocalStorageKeys.todoList.str,
      valueIter: dataList,
    );
  }
}
