import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simpletodo/bloc/todo_list/todo_list_bloc.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/domain/repository/todo/todo_repository_impl.dart';
import 'package:simpletodo/ui/add_todo/page/add_todo_page.dart';
import 'package:simpletodo/ui/home/widget/todo_calendar.dart';
import 'package:simpletodo/ui/home/widget/todo_panel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TodoRepositoryImpl(),
      child: BlocProvider(
        lazy: false,
        create: (context) => TodoListBloc(
          todoRepo: RepositoryProvider.of<TodoRepositoryImpl>(context),
        ),
        child: const _HomePageBody(),
      ),
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
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          BlocBuilder<TodoListBloc, TodoListState>(
            builder: (context, state) => switch (state) {
              TodoListInitial _ => Container(),
              TodoListLoading _ => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              TodoListLoaded loaded => TodoPanel(
                  todos: loaded.todos,
                  onRefresh: context.read<TodoListBloc>().refresh,
                ),
              TodoListError error => Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colorTheme.error,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 12.0),
                    child: Text(
                      error.exception.toString(),
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.colorTheme.onError,
                      ),
                    ),
                  ),
                ),
              // ignore: unreachable_switch_case
              _ => Container(),
            },
          ),
          BlocBuilder<TodoListBloc, TodoListState>(
            builder: (context, state) => switch (state) {
              TodoListInitial _ => Container(),
              TodoListLoading _ => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              TodoListLoaded loaded => TodoCalendar(
                  todos: loaded.todos,
                ),
              TodoListError error => Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colorTheme.error,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 12.0,
                    ),
                    child: Text(
                      error.exception.toString(),
                      style: context.textTheme.labelLarge?.copyWith(
                        color: context.colorTheme.onError,
                      ),
                    ),
                  ),
                ),
              // ignore: unreachable_switch_case
              _ => Container(),
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: _currentIndex == 0
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorTheme.onPrimary,
                        foregroundColor: context.colorTheme.primary,
                        textStyle: context.textTheme.titleSmall?.copyWith(
                          color: context.colorTheme.primary,
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddTodoPage()),
                      ).then((_) => context.read<TodoListBloc>().refresh()),
                      child: const Text("일정 추가"),
                    ),
                  )
                ],
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: context.colorTheme.onPrimary,
        unselectedItemColor: context.colorTheme.outline,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedIconTheme: IconThemeData(size: 28.0),
        unselectedIconTheme: IconThemeData(size: 24.0),
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
