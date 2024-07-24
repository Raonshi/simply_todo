import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:simpletodo/ui/simple_todo_app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const SimpleTodoApp());
}
