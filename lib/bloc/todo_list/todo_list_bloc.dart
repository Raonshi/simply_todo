import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:simpletodo/domain/repository/todo/todo_repository.dart';

part 'todo_list_state.dart';

class TodoListBloc extends Cubit<TodoListState> {
  final TodoRepository todoRepo;

  TodoListBloc({
    required this.todoRepo,
  }) : super(const TodoListInitial()) {
    _init();
  }

  void _init() async {
    emit(const TodoListLoading());
    try {
      final List<Todo> todos = await todoRepo.getTodoList();
      emit(TodoListLoaded(todos));
    } catch (e) {
      emit(TodoListError(e as Exception));
    }
  }

  void create(Todo todo) async {
    switch (state) {
      case TodoListLoaded loaded:
        final List<Todo> newTodos = [...loaded.todos, todo];
        emit(loaded.copyWith(todos: newTodos));
        await todoRepo.saveTodoList(newTodos);
        break;
      default:
        break;
    }
  }

  void toggleCheckbox(int index) async {
    switch (state) {
      case TodoListLoaded loaded:
        final List<Todo> newTodos = loaded.todos.toList();
        newTodos[index] = newTodos[index].copyWith(
          completed: !newTodos[index].completed,
        );
        emit(loaded.copyWith(todos: newTodos));
        await todoRepo.saveTodoList(newTodos);
        break;
      default:
        break;
    }
  }

  void deleteTodo(int index) async {
    switch (state) {
      case TodoListLoaded loaded:
        final List<Todo> newTodos = loaded.todos.toList();
        newTodos.removeAt(index);
        emit(loaded.copyWith(todos: newTodos));
        await todoRepo.saveTodoList(newTodos);
        break;
      default:
        break;
    }
  }
}
