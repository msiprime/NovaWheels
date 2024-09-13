abstract interface class PushNotificationRepository {
  Future<bool> requestPermission();

  void initializePushNotification();
}
