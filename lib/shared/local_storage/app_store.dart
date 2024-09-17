import 'package:flutter/material.dart';

abstract interface class AppStorageI {
  Future<void> storeIfUserFirstTimer(bool isUserFirstTimer);

  Future<bool> retrieveIfUserFirstTimer();

  Future<void> storeBearerToken(String token);

  Future<String?> retrieveBearerToken();

  Future<void> storeFcmToken(String token);

  Future<String?> retrieveFcmToken();

  Future<void> storeCredentials(Map<String, dynamic> credentials);

  Future<Map<String, dynamic>?> retrieveCredentials();

  Future<void> clearCredentials();

  Future<void> clearToken();

  Future<void> clearAllToken();

  Future<void> changeLanguage(String languageType);

  Future<String?> retrieveLanguage();

  Future<void> changeTheme(ThemeMode themeMode);

  Future<String?> retrieveTheme();
}
