import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;

  StreamSubscription<InternetStatus> get internetConnectivityStream;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;

  ConnectionCheckerImpl({required this.internetConnection});

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;

  @override
  StreamSubscription<InternetStatus> get internetConnectivityStream {
    final listener =
        internetConnection.onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          break;
        case InternetStatus.disconnected:
          break;
      }
    });
    return listener;
  }
}
