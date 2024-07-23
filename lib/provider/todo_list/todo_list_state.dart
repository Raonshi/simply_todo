part of 'todo_list_provider.dart';

sealed class TodoListState {
  const TodoListState();

  TodoListState copyWith();
}

class TodoListInitial extends TodoListState {
  const TodoListInitial();

  @override
  TodoListInitial copyWith() {
    return const TodoListInitial();
  }
}

class TodoListLoading extends TodoListState {
  const TodoListLoading();

  @override
  TodoListLoading copyWith() {
    return const TodoListLoading();
  }
}

class TodoListLoaded extends TodoListState {
  final List<Todo> todos;

  const TodoListLoaded({required this.todos});

  @override
  TodoListLoaded copyWith({
    List<Todo>? todos,
  }) {
    return TodoListLoaded(
      todos: todos ?? this.todos,
    );
  }
}

class TodoListError extends TodoListState {
  final Exception exception;

  const TodoListError({
    required this.exception,
  });

  @override
  TodoListError copyWith({
    Exception? exception,
  }) {
    return TodoListError(
      exception: exception ?? this.exception,
    );
  }
}
