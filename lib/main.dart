import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:simplytodo/core/service/notification_service.dart';
import 'package:simplytodo/core/service/sqlite_service.dart';
import 'package:simplytodo/ui/simple_todo_app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init();
  await SqliteService().init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const SimpleTodoApp());
}
