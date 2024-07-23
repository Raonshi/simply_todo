import 'package:flutter/material.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:simpletodo/ui/widget/todo_list_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 12.0,
                    ),
                    child: Text(
                      "일정이 없습니다.\n일정을 추가해주세요.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(onPressed: () {}, child: const Text("일정 추가")),
              ],
            ),
          )
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoListItem(
                data: todos[index],
                onTapCheckbox: () {},
                onTapDelete: () {},
              );
            },
          );
  }
}
