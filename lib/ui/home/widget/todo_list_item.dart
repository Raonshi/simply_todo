import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/model/todo_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoListItem extends StatefulWidget {
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
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  late bool _isExpand;

  @override
  void initState() {
    _isExpand = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            onPressed: (context) => widget.onTapDelete(),
            icon: Icons.delete,
            backgroundColor: context.colorTheme.error,
            foregroundColor: context.colorTheme.onError,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.colorTheme.primary,
              border:
                  Border.all(color: context.colorTheme.onPrimary, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
            child: Row(
              children: [
                Checkbox.adaptive(
                  value: widget.data.completed,
                  activeColor: context.colorTheme.onPrimary,
                  checkColor: context.colorTheme.primary,
                  onChanged: (_) => widget.onTapCheckbox(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.data.title,
                                  style: context.textTheme.titleSmall,
                                ),
                                const SizedBox(height: 4.0),
                                if (_isExpand)
                                  Text(
                                    widget.data.content,
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      color: context.colorTheme.secondary,
                                    ),
                                  )
                                else
                                  Text(
                                    widget.data.content.split("\n").length >= 2
                                        ? "${widget.data.content.split("\n")[0]} ..."
                                        : widget.data.content,
                                    style:
                                        context.textTheme.bodyMedium?.copyWith(
                                      color: context.colorTheme.secondary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (widget.data.content.split("\n").length >= 2)
                            IconButton(
                              onPressed: () =>
                                  setState(() => _isExpand = !_isExpand),
                              icon: RotatedBox(
                                quarterTurns: _isExpand ? 2 : 0,
                                child: Icon(
                                  Icons.expand_more,
                                  color: context.colorTheme.onPrimary,
                                ),
                              ),
                            )
                        ],
                      ),

                      // Notification Date Time
                      if (widget.data.showNotification)
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: DateFormat("yyyy. MM. dd").format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        widget.data.timestamp),
                                  ),
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: context.colorTheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: " 까지",
                                  style: context.textTheme.labelSmall?.copyWith(
                                    color: context.colorTheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.colorTheme.onPrimary,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(left: 8.0),
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.notifications,
              size: 16.0,
              color: context.colorTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
