import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppSecrets {
  static String get geminiApiKey =>
      dotenv.env['GEMINI_API_KEY_PAID'] ?? 'default';

  static String get supaBaseUrl => dotenv.env['SUPABASE_URL'] ?? 'default_url';

  static String get supaAnonKey =>
      dotenv.env['SUPABASE_ANON_KEY'] ?? 'default_key';

  // fire base config

  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? 'default_realtime_url';

  static String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? 'null';

  // fire base android config

  static String get firebaseAndroidApiKey =>
      dotenv.env['FIREBASE_ANDROID_API_KEY'] ?? 'null';

  static String get firebaseAndroidAppId =>
      dotenv.env['FIREBASE_ANDROID_APP_ID'] ?? 'null';

  static String get firebaseAndroidMessagingSenderId =>
      dotenv.env['FIREBASE_ANDROID_MESSAGING_SENDER_ID'] ??
      'default_realtime_url';

// fire base ios config

  static String get firebaseIosApiKey =>
      dotenv.env['FIREBASE_IOS_API_KEY'] ?? 'null';

  static String get firebaseIosAppId =>
      dotenv.env['FIREBASE_IOS_APP_ID'] ?? 'null';

  static String get firebaseIosMessagingSenderId =>
      dotenv.env['FIREBASE_IOS_MESSAGING_SENDER_ID'] ?? 'null';

  // google sign in

  static String get webClientId => dotenv.env['WEB_CLIENT_ID'] ?? 'null';

  static String get iosClientId => dotenv.env['IOS_CLIENT_ID'] ?? 'null';
}
