import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplytodo/common/theme.dart';
import 'package:simplytodo/todo/ui/add/bloc/add_todo_bloc.dart';

class AddTodoTitleField extends StatelessWidget {
  const AddTodoTitleField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        cursorColor: context.colorTheme.onPrimary,
        maxLength: 50,
        decoration: InputDecoration(
          labelText: "제목",
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
        textInputAction: TextInputAction.next,
        onChanged: context.read<AddTodoBloc>().setTitle,
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        validator: (String? value) {
          if ((value ?? "").isEmpty) {
            return "제목을 입력해주세요.";
          }
          return null;
        },
      ),
    );
  }
}
