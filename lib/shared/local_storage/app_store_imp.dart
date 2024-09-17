import 'package:flutter/material.dart';
import 'package:nova_wheels/shared/local_storage/app_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorageImp implements AppStorageI {
  static Future<SharedPreferences> getPrefs() async {
    return SharedPreferences.getInstance();
  }

  static const String _keyBearerToken = 'bearer_token';
  static const String _keyUserEmail = 'user_email';
  static const String _keyPassword = 'password';
  static const String _keyFcmToken = 'fcm-token';
  static const String _keyTheme = 'theme';
  static const String _keyLanguage = 'language';
  static const String _keyIsUserFirstTimer = 'is-user-first-timer';

  @override
  Future<void> storeIfUserFirstTimer(bool isUserFirstTimer) async {
    SharedPreferences prefs = await getPrefs();
    prefs.setBool(_keyIsUserFirstTimer, isUserFirstTimer);
  }

  @override
  Future<bool> retrieveIfUserFirstTimer() async {
    return await getPrefs()
        .then((prefs) => prefs.getBool(_keyIsUserFirstTimer) ?? true);
  }

  @override
  Future<void> storeBearerToken(String token) async {
    SharedPreferences prefs = await getPrefs();
    prefs.setString(_keyBearerToken, token);
  }

  @override
  Future<String?> retrieveBearerToken() async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getString(_keyBearerToken);
  }

  @override
  Future<Map<String, dynamic>?> retrieveCredentials() async {
    SharedPreferences prefs = await getPrefs();
    String? userEmail = prefs.getString(_keyUserEmail);
    String? password = prefs.getString(_keyPassword);

    if (userEmail != null && password != null) {
      return {'userEmail': userEmail, 'password': password};
    }

    return null;
  }

  @override
  Future<void> storeCredentials(Map<String, dynamic> credentials) async {
    SharedPreferences prefs = await getPrefs();

    String userEmail = credentials['userEmail'];
    String password = credentials['password'];

    prefs.setString(_keyUserEmail, userEmail);
    prefs.setString(_keyPassword, password);
  }

  @override
  Future<void> clearToken() async {
    SharedPreferences prefs = await getPrefs();
    prefs.remove(_keyBearerToken);
  }

  @override
  Future<void> clearCredentials() async {
    SharedPreferences prefs = await getPrefs();

    prefs.remove(_keyUserEmail);
    prefs.remove(_keyPassword);
  }

  @override
  Future<void> storeFcmToken(String token) async {
    SharedPreferences prefs = await getPrefs();
    prefs.setString(_keyFcmToken, token);
  }

  @override
  Future<String?> retrieveFcmToken() async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getString(_keyFcmToken);
  }

  @override
  Future<void> changeLanguage(String languageType) async {
    SharedPreferences prefs = await getPrefs();
    prefs.setString(_keyLanguage, languageType);
  }

  @override
  Future<void> changeTheme(ThemeMode themeMode) async {
    SharedPreferences prefs = await getPrefs();
    prefs.setString(_keyTheme, themeMode.name);
  }

  @override
  Future<String?> retrieveLanguage() async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getString(_keyLanguage);
  }

  @override
  Future<String?> retrieveTheme() async {
    SharedPreferences prefs = await getPrefs();
    return prefs.getString(_keyTheme);
  }

  @override
  Future<void> clearAllToken() async {
    SharedPreferences prefs = await getPrefs();
    prefs.remove(_keyBearerToken);
    prefs.remove(_keyFcmToken);
  }
}
