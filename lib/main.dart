import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:simpletodo/service/notification_service.dart';
import 'package:simpletodo/ui/simple_todo_app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await NotificationService().scheduleNotification(
    id: 0,
    title: 'Simple Todo',
    body: 'Welcome to Simple Todo!',
    timestamp: DateTime.now().millisecondsSinceEpoch,
  );

  runApp(const SimpleTodoApp());
}
