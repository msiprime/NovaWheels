abstract interface class PushNotificationDataSource {
  Future<bool> requestPermission();

  void initializePushNotification();
}
