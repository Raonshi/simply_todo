import 'package:flutter/material.dart';
import 'package:simpletodo/common/theme.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            onPressed: (context) => onTapDelete(),
            icon: Icons.delete,
            backgroundColor: context.colorTheme.error,
            foregroundColor: context.colorTheme.onError,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 20.0,
        ),
        child: Container(
          constraints: const BoxConstraints.tightFor(height: 64.0),
          decoration: BoxDecoration(
            color: context.colorTheme.primary,
            border: Border.all(color: context.colorTheme.onPrimary, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: Row(
            children: [
              Checkbox.adaptive(
                value: data.completed,
                activeColor: context.colorTheme.onPrimary,
                checkColor: context.colorTheme.primary,
                onChanged: (_) => onTapCheckbox(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4.0),
                    Expanded(
                      child: Text(
                        data.content,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorTheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
