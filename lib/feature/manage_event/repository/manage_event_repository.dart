import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:event_radar2/feature/manage_event/data/content_visual_input_model.dart';
import 'package:event_radar2/feature/manage_event/data/event_detail_input_model.dart';
import 'package:event_radar2/feature/manage_event/data/my_event_model.dart';
import 'package:event_radar2/feature/manage_event/data/ticket_model.dart';
import 'package:event_radar2/network/api_services.dart';
import 'package:event_radar2/network/secure_storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
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

  Future<String> createEvent(
    EventDetailInputModel eventDetail,
    ContentVisualInputModel content,
    List<TicketInputModel> tickets,
  ) async {
    try {
      // Parse base event date (e.g. from "2025-06-03")
      final eventDate = DateTime.parse(eventDetail.dateController.text);

      // Parse time-only strings like "4:00 AM" and "6:00 PM"
      final startTime =
          DateFormat.jm().parse(eventDetail.startTimeController.text);
      final endTime = DateFormat.jm().parse(eventDetail.endTimeController.text);

      // Combine the date and time
      final eventDateTime = DateTime(
        eventDate.year,
        eventDate.month,
        eventDate.day,
        startTime.hour,
        startTime.minute,
      );
      final eventEndDateTime = DateTime(
        eventDate.year,
        eventDate.month,
        eventDate.day,
        endTime.hour,
        endTime.minute,
      );

      // Convert ticket info
      List<Map<String, dynamic>> ticketsJsonList = tickets.map((ticket) {
        return {
          "ticket_type": ticket.nameController.text,
          "registration_end": DateTime.parse(ticket.dateController.text)
              .toUtc()
              .toIso8601String(),
          "ticket_limit": int.parse(ticket.quantityController.text),
          "price": int.parse(ticket.priceController.text.replaceAll('.', '')),
          "description": ticket.descriptionController.text,
        };
      }).toList();

      // Final event model map
      final modelData = {
        "name": eventDetail.titleController.text,
        "event_detail": content.controller.document.toPlainText(),
        "event_datetime": eventDateTime.toUtc().toIso8601String(),
        "event_end_datetime": eventEndDateTime.toUtc().toIso8601String(),
        "max_participants":
            int.parse(eventDetail.maxParticipantsController.text),
        "location": eventDetail.locationController.text,
        "is_approved": false,
        "is_online": eventDetail.selectedEventType == "Online",
        "categories": eventDetail.categoryController.selectedItems
            .map((e) => e.value)
            .toList(),
        "tickets": ticketsJsonList,
      };

      // FormData with JSON string
      final formData = FormData.fromMap({
        "data": jsonEncode(modelData),
        "status": "waiting",
        "event_thumbnail": await MultipartFile.fromFile(
          content.userImage!.path,
          filename: content.userImage!.path.split("/").last,
        ),
      });

      final response = await apiService.postApiDataWithToken(
        dotenv.env['EVENT'] ?? "",
        formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Event created successfully';
      }

      throw response.data;
    } catch (e, stackTrace) {
      Logger().e('Error in createEvent: $e', stackTrace: stackTrace);
      throw e;
    }
  }
}
