import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Store a session token securely
  Future<void> storeSessionToken(String token) async {
    await _secureStorage.write(key: 'session_token', value: token);
  }

  Future<void> storeSessionExp(String sessionExp) async {
    await _secureStorage.write(key: "session_exp", value: sessionExp);
  }

  Future<void> storeFCMToken(String token) async {
    await _secureStorage.write(key: 'fcm_token', value: token);
  }

  Future<void> storeUserRole(String role) async {
    await _secureStorage.write(key: 'role', value: role);
  }

  Future<void> storeUserId(String userId) async {
    await _secureStorage.write(key: "user_id", value: userId);
  }

  Future<void> storePassword(String password) async {
    await _secureStorage.write(key: "password", value: password);
  }

  Future<void> storeRememberMe(String rememberMe) async {
    await _secureStorage.write(key: "remember_me", value: rememberMe);
  }

  // Retrieve the stored session token
  Future<String?> getSessionToken() async {
    return await _secureStorage.read(key: 'session_token');
  }

  Future<String?> getUserRole() async {
    return await _secureStorage.read(key: 'role');
  }

  Future<String?> getFCMToken() async {
    return await _secureStorage.read(key: 'fcm_token');
  }

  Future<DateTime?> getSessionExp() async {
    String? sessionExp = await _secureStorage.read(key: "session_exp");

    if (sessionExp != null) {
      final int expTimestamp = int.tryParse(sessionExp) ?? 0;
      return DateTime.fromMillisecondsSinceEpoch(expTimestamp * 1000);
    }

    return null;
  }

  Future<String?> getUserId() async {
    return await _secureStorage.read(key: 'user_id');
  }

  Future<String?> getPassword() async {
    return await _secureStorage.read(key: 'password');
  }

  // Delete the session token
  Future<void> deleteSessionToken() async {
    await _secureStorage.delete(key: 'session_token');
  }

  // Clear all secure storage (for example, when logging out)
  Future<void> clearStorage() async {
    await _secureStorage.deleteAll();
  }

  Future<void> clearStorageWithRememberMe() async {
    await _secureStorage.delete(key: 'session_token');
    await _secureStorage.delete(key: 'fcm_token');
  }
}
