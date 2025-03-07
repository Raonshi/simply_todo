import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simplytodo/core/repository/notification_repository.dart';
import 'package:simplytodo/ui/calendar/widget/calendar_view.dart';
import 'package:simplytodo/ui/home/bloc/home_bloc.dart';
import 'package:simplytodo/ui/todo_list/bloc/todo_list_bloc.dart';
import 'package:simplytodo/common/theme.dart';
import 'package:simplytodo/repository/todo_repository.dart';
import 'package:simplytodo/ui/add_todo/widget/add_todo_page.dart';
import 'package:simplytodo/ui/todo_list/widget/todo_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => TodoListBloc(
            todoRepo: context.read<TodoRepository>(),
            notiRepo: context.read<NotificationRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ],
      child: const _HomePageBody(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "심플리투두",
          style: context.textTheme.displayMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.plus),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddTodoPage())).then(
              (_) {
                context.read<TodoListBloc>().refresh();
              },
            ),
          ),
        ],
      ),
      body: BlocSelector<HomeBloc, HomeState, int>(
        selector: (state) => state.idx,
        builder: (context, idx) => switch (idx) {
          0 => TodoListView(),
          1 => CalendarView(),
          _ => SizedBox(),
        },
      ),
      bottomNavigationBar: BlocSelector<HomeBloc, HomeState, int>(
        selector: (state) => state.idx,
        builder: (context, tabIdx) {
          return BottomNavigationBar(
            currentIndex: tabIdx,
            onTap: (value) {
              context.read<HomeBloc>().add(ChangeHomeTab(value));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.listCheck),
                label: "목록",
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.calendar),
                label: "달력",
              ),
            ],
          );
        },
      ),
    );
  }
}
