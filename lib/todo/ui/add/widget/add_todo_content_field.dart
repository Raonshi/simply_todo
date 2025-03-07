import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplytodo/common/theme.dart';
import 'package:simplytodo/todo/ui/add/bloc/add_todo_bloc.dart';

class AddTodoContentField extends StatelessWidget {
  const AddTodoContentField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        cursorColor: context.colorTheme.onPrimary,
        minLines: 10,
        maxLines: 10,
        decoration: InputDecoration(
          labelText: "내용",
          labelStyle: context.textTheme.titleSmall?.copyWith(
            color: context.colorTheme.onPrimary,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: context.colorTheme.onPrimary,
              width: 1.5,
            ),
          ),
        ),
        onChanged: context.read<AddTodoBloc>().setContent,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
