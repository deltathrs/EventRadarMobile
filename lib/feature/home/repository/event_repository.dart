import 'package:event_radar2/feature/home/data/event_detail_model.dart';
import 'package:event_radar2/feature/home/data/event_model.dart';
import 'package:event_radar2/feature/profile/data/ticket_detail_model.dart';
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

      final events = response.data['data']?['events'];
      if (events == null) {
        return []; // Jika 'events' null, return list kosong
      }

      return List<Map<String, dynamic>>.from(events)
          .map((item) => EventModel.fromJson(item))
          .toList();
    } catch (e, stackTrace) {
      _logger.e('Error getEventList: $e', stackTrace: stackTrace);
      throw e;
    }
  }

  Future<String> addEventToFavourite(String eventId) async {
    try {
      final response = await apiService.putApiData(
          "${dotenv.env['FAVOURITE']!}/$eventId", null);

      if (response.statusCode == 200) {
        return response.data['data']['message'];
      }
      throw response.data;
    } catch (e, stackTrace) {
      Logger().e("Error AddToFavourite: $e", stackTrace: stackTrace);
      throw e;
    }
  }

  Future<List<EventModel>> getFavouriteEventList() async {
    try {
      final response = await apiService.getApiData(dotenv.env['FAVOURITE']!);

      if (response.statusCode == 200) {
        final events = response.data['data'];
        if (events == null) {
          return []; // Jika 'events' null, return list kosong
        }

        return List<Map<String, dynamic>>.from(events)
            .map((item) => EventModel.fromJson(item))
            .toList();
      }
      throw response.data;
    } catch (e, stackTrace) {
      Logger().e("Error getFavouriteEventList: $e", stackTrace: stackTrace);
      throw e;
    }
  }

  Future<EventDetailModel> getEventDetail(String eventId) async {
    try {
      final response =
          await apiService.getApiData("${dotenv.env['EVENT']}/$eventId");

      return EventDetailModel.fromJson(response.data['data']);
    } catch (e, stackTrace) {
      _logger.e('Error getEventDetail: $e', stackTrace: stackTrace);
      throw e;
    }
  }

  Future<String> buyEvent(String ticketId) async {
    try {
      final response =
          await apiService.getApiData("${dotenv.env['BUY_TICKET']}/$ticketId");

      return response.data['data']['message'];
    } catch (e, stackTrace) {
      _logger.e('Error buyEvent: $e', stackTrace: stackTrace);
      throw e;
    }
  }

  Future<List<TicketDetailModel>> getTicketDetailList() async {
    try {
      final response = await apiService.getApiData("${dotenv.env['TICKET']}");

      final events = response.data['data'];
      if (events == null) {
        return []; // Jika 'events' null, return list kosong
      }

      return List<Map<String, dynamic>>.from(events)
          .map((item) => TicketDetailModel.fromJson(item))
          .toList();
    } catch (e, stackTrace) {
      _logger.e('Error getTicketDetailList: $e', stackTrace: stackTrace);
      throw e;
    }
  }
}
