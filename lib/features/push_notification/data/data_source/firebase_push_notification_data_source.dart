import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nova_wheels/features/push_notification/data/data_source/push_notification_data_source.dart';
import 'package:nova_wheels/features/push_notification/data/model/push_notification_response.dart';

class FirebasePushNotificationDataSource implements PushNotificationDataSource {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<bool> requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
    );

    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  void onNotificationReceived(
      PushNotificationResponse notificationResponse) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    const androidNotificationDetails = AndroidNotificationDetails(
        'localpushnotification', 'localpushnotification channel',
        channelDescription: 'localpushnotification',
        importance: Importance.max,
        priority: Priority.high);

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _notificationPlugin.show(
      id,
      notificationResponse.title,
      notificationResponse.body,
      notificationDetails,
    );
  }

  @override
  void initializePushNotification() {
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    _notificationPlugin.initialize(
      initializationSettings,
    );

    FirebaseMessaging.onMessage.listen(
      (event) {
        PushNotificationResponse notification = PushNotificationResponse(
          event.notification?.title ?? "",
          event.notification?.body ?? "",
        );
        onNotificationReceived(notification);
      },
    );
  }
}
