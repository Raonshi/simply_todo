import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  late final FlutterLocalNotificationsPlugin _notiPlugin;

  InitializationSettings get _initializationSettings =>
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
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
      log('NotificationService initialized');
    } else {
      log('Failed to initialize NotificationService');
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

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int timestamp,
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

    await _notiPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    _notiPlugin.pendingNotificationRequests().then((value) {
      log('Pending notifications: ${value.map((e) => e.title)}');
    });
  }

  /// Remove scheduled notification with [id].
  Future<void> cancelScheduledNotification(int id) async {
    await _notiPlugin.cancel(id);
  }
}
