part of 'notification_repository.dart';

final class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _service = NotificationService();

  NotificationRepositoryImpl();
  @override
  void cancelScheduledNotification(int id) =>
      _service.cancelScheduledNotification(id);

  @override
  void scheduleNotification(NotificationPayloadModel payload) =>
      _service.scheduleNotification(payload);
}
