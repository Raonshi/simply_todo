import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simplytodo/ui/calendar/widget/calendar_view.dart';
import 'package:simplytodo/ui/todo_list/bloc/todo_list_bloc.dart';
import 'package:simplytodo/common/theme.dart';
import 'package:simplytodo/repository/todo_repository.dart';
import 'package:simplytodo/ui/add_todo/widget/add_todo_page.dart';
import 'package:simplytodo/ui/todo_list/widget/todo_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => TodoListBloc(
        todoRepo: context.read<TodoRepository>(),
      ),
      child: const _HomePageBody(),
    );
  }
}

class _HomePageBody extends StatefulWidget {
  const _HomePageBody();

  @override
  State<_HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<_HomePageBody> {
  late int _currentIndex;
  late final PageController _pageController;

  @override
  void initState() {
    _currentIndex = 0;
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

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
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          TodoListView(),
          CalendarView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: context.colorTheme.onPrimary,
        unselectedItemColor: context.colorTheme.outline,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedIconTheme: const IconThemeData(size: 28.0),
        unselectedIconTheme: const IconThemeData(size: 24.0),
        onTap: (value) {
          setState(() => _currentIndex = value);
          _pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
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
      ),
    );
  }
}
