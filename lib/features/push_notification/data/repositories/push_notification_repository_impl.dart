import 'package:nova_wheels/features/push_notification/data/data_source/push_notification_data_source.dart';
import 'package:nova_wheels/features/push_notification/domain/repositories/push_notification_repository.dart';

class PushNotificationRepositoryImpl implements PushNotificationRepository {
  final PushNotificationDataSource _pushNotificationDataSource;

  PushNotificationRepositoryImpl(this._pushNotificationDataSource);

  @override
  void initializePushNotification() {
    _pushNotificationDataSource.initializePushNotification();
  }

  @override
  Future<bool> requestPermission() async {
    return await _pushNotificationDataSource.requestPermission();
  }
}
