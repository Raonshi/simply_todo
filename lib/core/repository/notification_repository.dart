import 'package:simplytodo/core/service/notification_service.dart';
import 'package:simplytodo/model/notification_payload_model.dart';

part 'notification_repository_impl.dart';

abstract interface class NotificationRepository {
  /// 알림 1개 추가
  void scheduleNotification(NotificationPayloadModel payload);

  /// 스케줄된 알림 중 id값과 일치하는 알링을 취소
  void cancelScheduledNotification(int id);
}
