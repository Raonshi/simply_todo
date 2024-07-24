import 'package:flutter/material.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/model/todo_model.dart';

class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({super.key});

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _contentCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleCtrl = TextEditingController();
    _contentCtrl = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "일정 추가",
              style: context.textTheme.titleSmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _titleCtrl,
                cursorColor: context.colorTheme.onPrimary,
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: "제목",
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
                validator: (String? value) {
                  if ((value ?? "").isEmpty) {
                    return "제목을 입력해주세요.";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _contentCtrl,
                cursorColor: context.colorTheme.onPrimary,
                minLines: 10,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: "내용",
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
              ),
            ),
            const SizedBox(height: 24.0),
            InkWell(
              onTap: () {
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.pop(
                    context,
                    Todo(
                      id: DateTime.now().millisecondsSinceEpoch,
                      title: _titleCtrl.text,
                      content: _contentCtrl.text,
                    ),
                  );
                }
              },
              child: Container(
                color: context.colorTheme.onPrimary,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                child: SafeArea(
                  child: Text(
                    "일정 추가",
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorTheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
