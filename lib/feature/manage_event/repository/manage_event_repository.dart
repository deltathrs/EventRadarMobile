import 'package:event_radar2/feature/manage_event/data/content_visual_input_model.dart';
import 'package:event_radar2/feature/manage_event/data/event_detail_input_model.dart';
import 'package:event_radar2/feature/manage_event/data/my_event_model.dart';
import 'package:event_radar2/feature/manage_event/data/ticket_model.dart';
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

  // Future<String> createEvent(EventDetailInputModel eventDetail,
  //     ContentVisualInputModel content, List<TicketInputModel> tickets) async {
  //   List<Map<String, dynamic>> ticketsJsonList = tickets.map((ticket) {
  //     return {
  //       "ticket_type": ticket.nameController.text,
  //       "registration_end":
  //           DateTime.parse(ticket.dateController.text).toIso8601String(),
  //       "ticket_limit": int.parse(ticket.quantityController.text),
  //       "price": ticket.priceController.text,
  //       "description": ticket.descriptionController.text,
  //     };
  //   }).toList();

  //   final modelData = {
  //     "name": eventDetail.titleController.text,
  //     "event_detail": content.controller.document.toPlainText(),
  //     "event_datetime":
  //         DateTime.parse(eventDetail.dateController.text).toIso8601String(),
  //     "event_end_datetime":
  //         eventDetail.eventEndDatetime.toIso8601String(), // Format DateTime
  //     "max_participants": eventDetail.maxParticipants,
  //     "location": eventDetail.location,
  //     "is_approved": eventDetail.isApproved,
  //     "is_online": eventDetail.isOnline,
  //     "categories":
  //         eventDetail.categories, // Assumes this is already List<String>
  //     "tickets": ticketsJsonList,
  //   };
  // }
}
