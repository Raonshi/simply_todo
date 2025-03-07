import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplytodo/core/repository/notification_repository.dart';
import '../repository/todo_repository.dart';

List<RepositoryProvider> get configureDependencies => [
      RepositoryProvider<TodoRepository>(
        create: (context) => TodoRepositoryImpl(),
      ),
      RepositoryProvider<NotificationRepository>(
        create: (context) => NotificationRepositoryImpl(),
      ),
    ];
