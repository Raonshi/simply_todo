part of 'todo_list_bloc.dart';

sealed class TodoListState {
  const TodoListState();

  TodoListState copyWith();
}

class TodoListInitial extends TodoListState {
  const TodoListInitial();

  @override
  TodoListState copyWith() {
    return const TodoListInitial();
  }
}

class TodoListLoading extends TodoListState {
  const TodoListLoading();

  @override
  TodoListState copyWith() {
    return const TodoListLoading();
  }
}

class TodoListLoaded extends TodoListState {
  final List<TodoModel> todos;

  const TodoListLoaded(this.todos);

  @override
  TodoListState copyWith({
    List<TodoModel>? todos,
  }) {
    return TodoListLoaded(
      todos ?? this.todos,
    );
  }
}

class TodoListError extends TodoListState {
  final Exception exception;

  const TodoListError(this.exception);

  @override
  TodoListState copyWith({
    Exception? exception,
  }) {
    return TodoListError(
      exception ?? this.exception,
    );
  }
}
