import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServiceInstance {
  static late final LocalNotificationService localNotificationService;

  LocalNotificationServiceInstance() {
    localNotificationService = LocalNotificationService();
    localNotificationService.initialize().then((value) =>
        debugPrint("\n*** Local Notification Service is initialized ***\n\n"));
  }
}

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@drawable/app_icon.png");

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: showNotification,
    );

    InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    await _localNotificationService.initialize(settings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    // print(notificationResponse);
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'bs_23_service',
      "Cafe 23",
      channelDescription: "This is for cafe 23 application.",
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
    );

    return const NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(
          categoryIdentifier: 'plainCategory',
        ));
  }

  void showNotification(
      int id, String? title, String? body, String? payload) async {
    final notificationDetails = await _notificationDetails();
    await _localNotificationService.show(id, title, body, notificationDetails);
  }
}
