import 'package:event_radar2/feature/authentication/data/data_model.dart';
import 'package:event_radar2/network/api_services.dart';
import 'package:event_radar2/network/secure_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
      'fcm_token': UserStatus.deviceToken,
    };

    try {
      final response = await apiService.postApiDataWithoutToken(
          dotenv.env['LOGIN'] ?? "", modelData);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> decodedToken =
            JwtDecoder.decode(response.data['data']['token']);
        secureStorageService
            .storeSessionToken(response.data['data']['token'] ?? "");

        await secureStorageService.storeUserRole(decodedToken['role']);
        await secureStorageService
            .storeSessionExp(decodedToken['exp'].toString());

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

  Future<String> apiLogout() async {
    final modelData = {'fcm_token': UserStatus.deviceToken};

    try {
      final response = await apiService.postApiDataWithToken(
          dotenv.env['LOGOUT'] ?? "", modelData);

      if (response.statusCode == 200) {
        return response.data['data']['message'];
      }
      return response.data;
    } catch (e, stackTrace) {
      Logger().e('Error logout: $e', stackTrace: stackTrace);
      throw e;
    }
  }

  Future<void> signInWithGoogle() async {
    if (kDebugMode) {
      print('Starting Google Sign-In process...');
    }

    // Interactive signing in process
    final GoogleSignInAccount? gUser = await GoogleSignIn(
      forceCodeForRefreshToken: true,
      scopes: [
        'openid',
        'email',
        'profile',
      ],
      clientId:
          "592533004605-b1i1jedkfn5rq8cb0rhl8g3mjefs6sro.apps.googleusercontent.com",
      serverClientId:
          "592533004605-lujjb5t5lni3g1tg4md8e9o44314rvl7.apps.googleusercontent.com",
    ).signIn();

    if (gUser != null) {
      if (kDebugMode) {
        print('Google Sign-In successful. Retrieving auth details');
      }

      // Obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      print(gAuth);

      // Log Google Sign-In response
      if (kDebugMode) {
        print('Google Sign-In response: $gAuth');
      }

      print('Google Id Token: ${gAuth.idToken}');

      // Access token and ID token
      if (kDebugMode) {
        print('Access Token: ${gAuth.accessToken}');
      }

      // Retrieving user information (full name, email, and photo URL)
      String fullName = gUser.displayName ?? 'No name available';
      String email = gUser.email;
      String? photoUrl = gUser.photoUrl;
      final credential = GoogleAuthProvider.credential(
          idToken: gAuth.idToken, accessToken: gAuth.accessToken);

      print(credential);

      // if (kDebugMode) {
      //   print('Full Name: $fullName');
      //   print('Email: $email');
      //   print('Photo URL: $photoUrl');
      // }

      if (kDebugMode) {
        print('User information stored in SharedPreferences.');
      }

      // You can now use the access token and user details
      debugPrint('Access Google Token: ${gAuth.accessToken}', wrapWidth: 1024);

      secureStorageService.storeSessionToken(gAuth.idToken ?? "");

      await googleLogin();
      await GoogleSignIn().signOut();
    } else {
      // Handle sign-in cancellation
      if (kDebugMode) {
        print('Google Sign-In cancelled.');
      }
      throw 'Sign-in process was cancelled';
    }
  }

  Future<String> googleLogin() async {
    try {
      final modelData = {'fcm_token': UserStatus.deviceToken};
      final response = await apiService.postApiDataWithToken(
          dotenv.env['LOGIN_GOOGLE']!, modelData);

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> decodedToken =
            JwtDecoder.decode(response.data['token']);
        secureStorageService.storeSessionToken(response.data['token'] ?? "");

        await secureStorageService.storeUserRole(decodedToken['role']);
        await secureStorageService
            .storeSessionExp(decodedToken['exp'].toString());

        await prefs.setBool('isLoggedIn', true);

        UserStatus.isLoggedIn = true;
        return response.data['token'];
      }
      return response.data;
    } catch (e, stackTrace) {
      Logger().e('Error googleLogin: $e', stackTrace: stackTrace);
      throw e;
    }
  }

  Future<String> apiRegister(
      String email, String fullName, String password, bool isRoleEO) async {
    final modelData = {
      'email': email,
      'fullname': fullName,
      'password': password,
      'role': isRoleEO ? 'organizer' : 'regular',
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
