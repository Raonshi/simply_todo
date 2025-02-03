import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/todo_repository.dart';

List<RepositoryProvider> get configureDependencies => [
      RepositoryProvider<TodoRepository>(
        create: (context) => TodoRepositoryImpl(),
      ),
    ];
