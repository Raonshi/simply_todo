import 'package:flutter/material.dart';
import 'package:simpletodo/ui/page/home_page.dart';

class SimpleTodoApp extends StatelessWidget {
  const SimpleTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
