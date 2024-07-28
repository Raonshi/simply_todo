import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simpletodo/common/theme.dart';

class AddTodoInput extends StatefulWidget {
  const AddTodoInput({super.key, required this.label, required this.validator});

  final String label;
  final String? Function(String?) validator;

  @override
  State<AddTodoInput> createState() => _AddTodoInputState();
}

class _AddTodoInputState extends State<AddTodoInput> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    _ctrl = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _ctrl,
      cursorColor: context.colorTheme.onPrimary,
      maxLength: 50,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: context.textTheme.labelLarge?.copyWith(
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
      validator: widget.validator,
    );
  }
}
