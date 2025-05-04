import 'package:event_radar2/feature/home/data/event_detail_model.dart';
import 'package:event_radar2/feature/home/data/event_model.dart';
import 'package:event_radar2/network/api_services.dart';
import 'package:event_radar2/network/secure_storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class EventRepository {
  final SecureStorageService secureStorageService;
  final ApiService apiService;

  EventRepository(
      {required this.secureStorageService, required this.apiService});

  final Logger _logger = Logger();

  Future<List<EventModel>> getEventList(
      List<String> categories, String name, bool isOnline, int page) async {
    try {
      final modelData = {
        "categories": categories,
        "name": name,
        "is_online": isOnline,
        "page": page
      };

      final response = await apiService.postApiDataWithToken(
          "${dotenv.env['EVENTS']}", modelData);

      List<dynamic> jsonData = response.data['data']['events'];

      return jsonData
          .map((item) => EventModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e, stackTrace) {
      _logger.e('Error getEventList: $e', stackTrace: stackTrace);
      throw e;
    }
  }

  Future<EventDetailModel> getEventDetail(String eventId) async {
    try {
      final response = 
          await apiService.getApiData("${dotenv.env['EVENTS']}/$eventId");

      return EventDetailModel.fromJson(response.data['data']);
    } catch (e, stackTrace) {
      _logger.e('Error getEventDetail: $e', stackTrace: stackTrace);
      throw e;
    }
  }
}
