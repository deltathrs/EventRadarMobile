import 'package:event_radar2/feature/manage_event/data/my_event_model.dart';
import 'package:event_radar2/network/api_services.dart';
import 'package:event_radar2/network/secure_storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class ManageEventRepository {
  final ApiService apiService;
  final SecureStorageService secureStorageService;

  ManageEventRepository(
      {required this.apiService, required this.secureStorageService});

  Future<List<MyEventModel>> getMyEvent() async {
    try {
      final response =
          await apiService.getApiData(dotenv.env['MY_EVENT'] ?? "");

      final events = response.data['data']?['events'];
      if (events == null) {
        return [];
      }

      return List<Map<String, dynamic>>.from(events)
          .map((item) => MyEventModel.fromJson(item))
          .toList();
    } catch (e, stackTrace) {
      Logger().e('Error in getMyEvent: $e', stackTrace: stackTrace);
      throw e;
    }
  }

  Future<List<String>> getEventCategory() async {
    try {
      final response =
          await apiService.getApiData(dotenv.env['CATEGORY'] ?? "");

      final List<String> categories = List<String>.from(response.data['data']);
      return categories;
    } catch (e, stackTrace) {
      Logger().e('Error in getEventCategory: $e', stackTrace: stackTrace);
      throw e;
    }
  }
}
