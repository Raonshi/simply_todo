import 'package:flutter/material.dart';
import 'package:simpletodo/common/theme.dart';
import 'package:simpletodo/ui/home/page/home_page.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SimpleTodoApp extends StatelessWidget {
  const SimpleTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        title: "심플리투두",
        home: const HomePage(),
      ),
    );
  }
}
