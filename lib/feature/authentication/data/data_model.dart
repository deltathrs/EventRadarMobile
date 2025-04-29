// user_status.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStatus {
  static bool isLoggedIn = false;
  static String? deviceToken;
  static bool? alreadyAsk;
  static DateTime? isExpired;
  static bool? isDeviceGestureNavigationEnabled;
  static bool isRegister = false;

  static bool? isSessionExpired() {
    print("IS EXPIRED: $isExpired");
    if (isExpired == null) {
      return null; // If no expiration value is set, assume expired.
    } else if (DateTime.now().isAfter(isExpired!)) {
      return true; // If current time is after expiration time, session is expired.
    } else {
      return false; // If current time is before expiration time, session is valid.
    }
  }

  static Future<void> loadLoginStatus() async {
    FlutterSecureStorage _secureStorage = FlutterSecureStorage();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Load login status
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Load session expiration time as a DateTime
    final sessionExpString = await _secureStorage.read(key: 'session_exp');
    if (sessionExpString != null && sessionExpString.isNotEmpty) {
      isExpired = DateTime.tryParse(sessionExpString);
    } else {
      isExpired = null; // No expiration data
    }
  }
}
