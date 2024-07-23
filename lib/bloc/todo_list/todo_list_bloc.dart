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
      // final List<Todo> todos = await todoRepo.getTodoList();
      final List<Todo> todos = [
        Todo(
          id: 1,
          title: "Title 1",
          content: "Content 1",
          completed: false,
        ),
        Todo(
          id: 2,
          title: "Title 2",
          content: "Content 2",
          completed: false,
        ),
        Todo(
          id: 3,
          title: "Title 3",
          content: "Content 3",
          completed: false,
        ),
      ];
      emit(TodoListLoaded(todos));
    } catch (e) {
      emit(TodoListError(e as Exception));
    }
  }

  void create({required String title, required String content}) {
    switch (state) {
      case TodoListLoaded loaded:
        final List<Todo> newTodos = [
          ...loaded.todos,
          Todo(
            id: DateTime.now().millisecondsSinceEpoch,
            title: title,
            content: content,
            completed: false,
          )
        ];

        emit(loaded.copyWith(todos: newTodos));
        todoRepo.saveTodoList(newTodos);
        break;
      default:
        break;
    }
  }
}
