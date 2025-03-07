// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TodoListStateCWProxy {
  TodoListState todos(List<TodoModel> todos);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TodoListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TodoListState(...).copyWith(id: 12, name: "My name")
  /// ````
  TodoListState call({
    List<TodoModel> todos,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTodoListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTodoListState.copyWith.fieldName(...)`
class _$TodoListStateCWProxyImpl implements _$TodoListStateCWProxy {
  const _$TodoListStateCWProxyImpl(this._value);

  final TodoListState _value;

  @override
  TodoListState todos(List<TodoModel> todos) => this(todos: todos);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TodoListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TodoListState(...).copyWith(id: 12, name: "My name")
  /// ````
  TodoListState call({
    Object? todos = const $CopyWithPlaceholder(),
  }) {
    return TodoListState(
      todos: todos == const $CopyWithPlaceholder()
          ? _value.todos
          // ignore: cast_nullable_to_non_nullable
          : todos as List<TodoModel>,
    );
  }
}

extension $TodoListStateCopyWith on TodoListState {
  /// Returns a callable class that can be used as follows: `instanceOfTodoListState.copyWith(...)` or like so:`instanceOfTodoListState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TodoListStateCWProxy get copyWith => _$TodoListStateCWProxyImpl(this);
}
