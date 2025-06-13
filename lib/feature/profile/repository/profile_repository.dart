import 'dart:io';

import 'package:dio/dio.dart';
import 'package:event_radar2/feature/home/data/event_detail_model.dart';
import 'package:event_radar2/feature/profile/data/balance_model.dart';
import 'package:event_radar2/feature/profile/data/profile_model.dart';
import 'package:event_radar2/network/api_services.dart';
import 'package:event_radar2/network/secure_storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class ProfileRepository {
  final ApiService apiService;
  final SecureStorageService secureStorageService;

  ProfileRepository(
      {required this.apiService, required this.secureStorageService});

  Future<ProfileDataModel> getProfile() async {
    try {
      final response = await apiService.getApiData(dotenv.env['USER_PROFILE']!);

      if (response.statusCode == 200) {
        return ProfileDataModel.fromJson(response.data['data']);
      }

      return response.data;
    } catch (e, stackTrace) {
      Logger().e('Error getProfile: $e', stackTrace: stackTrace);
      throw e;
    }
  }

  Future<BalanceModel> getBalance() async {
    try {
      final response = await apiService.getApiData(dotenv.env['BALANCE']!);

      if (response.statusCode == 200) {
        return BalanceModel.fromJson(response.data['data']);
      }
      throw response.data;
    } catch (e, stackTrace) {
      Logger().e('Error in getBalance: $e', stackTrace: stackTrace);
      throw e;
    }
  }

  Future<String> editProfile(
      String fullName, String domicile, String phoneNumber) async {
    final modelData = {
      "fullname": fullName,
      "phone_number": phoneNumber,
      "domicile": domicile,
    };

    try {
      final response =
          await apiService.putApiData(dotenv.env['USER_PROFILE']!, modelData);

      if (response.statusCode == 200) {
        return response.data['data']['message'];
      }
      throw response.data;
    } catch (e, stackTrace) {
      Logger().e("Error in putProfileData: $e", stackTrace: stackTrace);
      throw e;
    }
  }

  Future<List<EventDetailModel>> getTicketList() async {
    try {
      final response = await apiService.getApiData(dotenv.env['TICKET']!);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data['data'];

        return jsonData
            .map((item) =>
                EventDetailModel.fromJson(Map<String, dynamic>.from(item)))
            .toList();
      }
      throw response.data;
    } catch (e, stackTrace) {
      Logger().e("Error in getTicketList: $e", stackTrace: stackTrace);
      throw e;
    }
  }

  Future<String> postImageProfile(File avatar) async {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(avatar.path,
          filename: avatar.path.split("/").last),
    });

    try {
      final response = await apiService.postApiDataWithToken(
          dotenv.env['USER_PROFILE_IMAGE']!, formData);

      if (response.statusCode == 200) {
        return "Change Profile Avatar Success";
      }

      throw response.data;
    } catch (e, stackTrace) {
      Logger().e("Error in postProfileAvatar: $e", stackTrace: stackTrace);
      throw e;
    }
  }
}
