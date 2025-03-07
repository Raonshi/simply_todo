part of 'todo_repository.dart';

final class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataService Function() dataService;
  final NotificationService _notificationService;

  TodoRepositoryImpl({
    TodoLocalDataService Function()? dataService,
    NotificationService? notificationService,
  })  : dataService = dataService ?? TodoLocalDataService.new,
        _notificationService = notificationService ?? NotificationService();

  @override
  Future<int> saveTodo(TodoModel todo) async {
    final int id = await dataService().saveTodo(todo.toJson());
    if (todo.showNotification) {
      await _notificationService.scheduleNotification(
        NotificationPayloadModel.create(
          title: todo.title,
          content: todo.content,
          scheduledDate: DateTime.now(),
          dueDate: todo.rangeDate?.end ?? todo.dueDate,
        ),
      );
    }
    return id;
  }

  @override
  Future<Iterable<TodoModel>> getTodoList() => dataService()
      .getTodoList()
      .then((jsonIter) => jsonIter.map(TodoModel.fromJson));

  @override
  Future<TodoModel> getTodo(int id) =>
      dataService().getTodo(id).then(TodoModel.fromJson);

  @override
  Future<int> updateTodo(TodoModel todo) =>
      dataService().updateTodo(todo.toJson());

  @override
  Future<void> deleteTodo(int id) => dataService().deleteTodo(id);

  @override
  Future<void> clearTodoList() => dataService().clearTodoTable();
}
