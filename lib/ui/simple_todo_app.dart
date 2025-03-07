import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplytodo/common/theme.dart';
import 'package:simplytodo/config/di.dart';
import 'package:simplytodo/ui/home/page/home_page.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SimpleTodoApp extends StatelessWidget {
  const SimpleTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: configureDependencies,
      child: GlobalLoaderOverlay(
        child: MaterialApp(
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          title: "심플리투두",
          home: const HomePage(),
        ),
      ),
    );
  }
}
