import 'package:flutter/material.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.data,
    required this.onTapCheckbox,
    required this.onTapDelete,
  });

  final Todo data;

  final VoidCallback onTapCheckbox;
  final VoidCallback onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onTapDelete(),
            icon: Icons.delete,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
        child: ListTile(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          style: ListTileStyle.list,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey.shade100, width: 1.0),
          ),
          tileColor: Colors.white,
          leading: Checkbox.adaptive(
            value: data.completed,
            onChanged: (_) => onTapCheckbox(),
          ),
          title: Text(data.title),
          titleTextStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          subtitle: Text(data.content),
          subtitleTextStyle: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
