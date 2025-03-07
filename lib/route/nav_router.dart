import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simplytodo/route/nav_path.dart';
import 'package:simplytodo/todo/ui/add/widget/add_todo_page.dart';
import 'package:simplytodo/ui/home/widget/home_page.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: NavPath.home.path,
      name: NavPath.home.path,
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: NavPath.addTodo.path,
      name: NavPath.addTodo.path,
      pageBuilder: (context, state) {
        return _SlideTransitionPage(
          child: AddTodoPage(),
        );
      },
    ),
  ],
);

final class _SlideTransitionPage extends CustomTransitionPage {
  _SlideTransitionPage({
    required super.child,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(1.25, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut)),
              ),
              child: child,
            );
          },
        );
}
