part of 'todo_list_bloc.dart';

@CopyWith(copyWithNull: true)
final class TodoListState {
  final List<TodoModel> todos;

  const TodoListState({
    this.todos = const [],
  });
}
