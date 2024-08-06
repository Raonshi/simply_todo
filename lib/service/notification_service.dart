import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simpletodo/common/tools.dart';
import 'package:simpletodo/domain/model/notification_payload_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  late final FlutterLocalNotificationsPlugin _notiPlugin;

  InitializationSettings get _initializationSettings =>
      const InitializationSettings(
        android:
            AndroidInitializationSettings('@mipmap/ic_launcher_foreground'),
        iOS: DarwinInitializationSettings(),
      );

  Future<void> init() async {
    tz.initializeTimeZones();
    final tz.Location location = tz.getLocation("Asia/Seoul");
    tz.setLocalLocation(location);

    _notiPlugin = FlutterLocalNotificationsPlugin();
    _requestPermissions();
    bool initialized =
        await _notiPlugin.initialize(_initializationSettings) ?? false;
    if (initialized) {
      lgr.d('NotificationService initialized');
    } else {
      lgr.d('Failed to initialize NotificationService');
    }
  }

  Future<void> _requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _notiPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notiPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool granted =
          await androidImplementation?.areNotificationsEnabled() ?? false;
      if (!granted) {
        await androidImplementation?.requestNotificationsPermission();
      }
    }
  }

  // Future<void> scheduleNotification({
  //   required int id,
  //   required String title,
  //   required String body,
  //   required DateTime dueDate,
  // }) async {
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'com.raondev.simplytodo.todo',
  //       '일정 알림',
  //       channelDescription: '심플리투두 앱의 일정 알림입니다.',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //     ),
  //     iOS: DarwinNotificationDetails(
  //       presentAlert: true,
  //       presentBadge: true,
  //       presentSound: true,
  //     ),
  //   );

  //   final tz.TZDateTime timeZoneDate = tz.TZDateTime.from(
  //     DateTime(dueDate.year, dueDate.month, dueDate.day, 9),
  //     tz.local,
  //   );

  //   await _notiPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     timeZoneDate,
  //     notificationDetails,
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //   );

  //   _notiPlugin.pendingNotificationRequests().then((value) {
  //     lgr.d('Pending notifications: ${value.map((e) => e.title)}');
  //   });
  // }

  Future<void> scheduleNotification(
      NotificationPayloadModel notification) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'com.raondev.simplytodo.todo',
        '일정 알림',
        channelDescription: '심플리투두 앱의 일정 알림입니다.',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notiPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.content,
      tz.TZDateTime.from(notification.dueDate, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: jsonEncode(notification.toMap()),
    );

    _notiPlugin.pendingNotificationRequests().then((value) {
      lgr.d('Pending notifications: ${value.map((e) => e.title)}');
    });
  }

  /// TEST function to schedule notification after 5 seconds.
  Future<void> testScheduleNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'com.raondev.simplytodo.todo',
        '일정 알림',
        channelDescription: '심플리투두 앱의 일정 알림입니다.',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    final tz.TZDateTime timeZoneDate = tz.TZDateTime.from(
      DateTime.now().add(const Duration(seconds: 5)),
      tz.local,
    );

    await _notiPlugin.zonedSchedule(
      id,
      title,
      body,
      timeZoneDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    _notiPlugin.pendingNotificationRequests().then((value) {
      lgr.d('Pending notifications: ${value.map((e) => e.title)}');
    });
  }

  /// Remove scheduled notification with [id].
  Future<void> cancelScheduledNotification(int id) async {
    await _notiPlugin.cancel(id);
    _notiPlugin.pendingNotificationRequests().then((value) {
      lgr.d('Pending notifications: ${value.map((e) => e.title)}');
    });
  }
}

@pragma('vm:entry-point')
void _onTapBackgroundNotification(NotificationResponse response) async {
  if (response.payload == null) return;

  final Map<String, dynamic> payload = jsonDecode(response.payload!);
  final NotificationPayloadModel notification =
      NotificationPayloadModel.fromJson(payload);

  final DateTime nextScheduleDate = notification.scheduledDate.add(
    const Duration(days: 1),
  );

  if (nextScheduleDate.isAfter(notification.dueDate)) return;

  final NotificationService notiService = NotificationService();
  await notiService.init();
  await notiService.scheduleNotification(notification.copyWith(
    scheduledDate: notification.scheduledDate.add(const Duration(days: 1)),
  ));
}
