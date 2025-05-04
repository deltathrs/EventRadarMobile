import 'package:event_radar2/feature/authentication/data/data_model.dart';
import 'package:event_radar2/network/api_services.dart';
import 'package:event_radar2/network/secure_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final ApiService apiService;
  final SecureStorageService secureStorageService;

  AuthRepository(
      {required this.apiService, required this.secureStorageService});

  Future<String> apiLogin(String email, String password) async {
    final modelData = {
      'email': email,
      'password': password,
    };

    try {
      final response = await apiService.postApiDataWithoutToken(
          dotenv.env['LOGIN'] ?? "", modelData);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        secureStorageService
            .storeSessionToken(response.data['data']['token'] ?? "");

        await prefs.setBool('isLoggedIn', true);

        UserStatus.isLoggedIn = true;

        return "Login Success";
      } else {
        throw response.data;
      }
    } catch (e, stackTrace) {
      Logger().e('Error login: $e', stackTrace: stackTrace);
      throw e;
    }
  }

  Future<String> apiRegister(
      String email, String fullName, String password) async {
    final modelData = {
      'email': email,
      'fullname': fullName,
      'password': password,
    };

    try {
      final response = await apiService.postApiDataWithoutToken(
          dotenv.env['REGISTER'] ?? "", modelData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['data']['message'];
      } else {
        throw response.data;
      }
    } catch (e, stackTrace) {
      Logger().e('Error register: $e', stackTrace: stackTrace);
      throw e;
    }
  }
}
