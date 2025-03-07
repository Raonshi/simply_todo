import 'package:simplytodo/model/notification_payload_model.dart';
import 'package:simplytodo/core/service/notification_service.dart';

import '../model/todo_model.dart';
import '../services/todo_local_data_service.dart';

part 'todo_repository_impl.dart';

abstract interface class TodoRepository {
  /// 데이터 베이스에 Todo 데이터를 1건 저장
  Future<int> saveTodo(TodoModel todo);

  /// 데이터 베이스에 저장된 전체 Todo 데이터를 조회
  Future<Iterable<TodoModel>> getTodoList();

  /// 데이터 베이스에 저장된 전체 Todo 데이터 중
  /// id와 일치하는 Todo 데이터 1건 조회
  Future<TodoModel> getTodo(int id);

  /// 데이터 베이스에 저장된 Todo 데이터를 1건 수정
  Future<int> updateTodo(TodoModel todo);

  /// 데이터 베이스에 저장된 Todo 데이터를 1건 삭제
  Future<void> deleteTodo(int id);

  /// 데이터 베이스에 저장된 전체 Todo 데이터를 삭제
  Future<void> clearTodoList();
}
