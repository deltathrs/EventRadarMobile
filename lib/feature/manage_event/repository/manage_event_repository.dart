import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:event_radar2/feature/home/data/event_detail_model.dart';
import 'package:event_radar2/feature/manage_event/data/content_visual_input_model.dart';
import 'package:event_radar2/feature/manage_event/data/event_detail_input_model.dart';
import 'package:event_radar2/feature/manage_event/data/my_event_model.dart';
import 'package:event_radar2/feature/manage_event/data/ticket_model.dart';
import 'package:event_radar2/network/api_services.dart';
import 'package:event_radar2/network/secure_storage_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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

  Future<String> changeEventStatus(String status, String id) async {
    try {
      final modelData = {'status': status};

      final response = await apiService.putApiData(
          "${dotenv.env['EDIT_EVENT_STATUS']!}/$id/status", modelData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['data']['message'];
      }
      throw response.data;
    } catch (e, stackTrace) {
      Logger().e('Error in changeEventStatus: $e', stackTrace: stackTrace);
      throw e;
    }
  }

  Future<String> editEvent(
    EventDetailInputModel eventDetail,
    String id, {
    ContentVisualInputModel? content,
    List<TicketInputModel>? tickets,
    String? status,
  }) async {
    try {
      final eventDate = DateTime.parse(eventDetail.dateController.text);

      final startTime =
          DateFormat.jm().parse(eventDetail.startTimeController.text);
      final endTime = DateFormat.jm().parse(eventDetail.endTimeController.text);

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

      // Convert ticket info only if tickets are provided
      List<Map<String, dynamic>> ticketsJsonList = [];
      if (tickets != null) {
        ticketsJsonList = tickets.map((ticket) {
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
      }

      final modelData = {
        "name": eventDetail.titleController.text,
        "event_detail": content?.controller.document.toPlainText() ?? '',
        "datetime": eventDateTime.toUtc().toIso8601String(),
        "end_datetime": eventEndDateTime.toUtc().toIso8601String(),
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

      Logger().i('modelData: ${jsonEncode(modelData)}');
      Logger().i('Thumbnail path: ${content?.userImage?.path}');

      // Build form data
      final formMap = {
        "data": jsonEncode(modelData),
        'event_thumbnail': content?.userImage != null
            ? await MultipartFile.fromFile(
                content!.userImage!.path,
                filename: content.userImage!.path.split("/").last,
              )
            : null,
        "status": status ?? "waiting",
      };

      final formData = FormData.fromMap(formMap);

      final response = await apiService.putApiData(
        "${dotenv.env['EVENT']!}/$id",
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

  Future<String> createEvent(
    EventDetailInputModel eventDetail, {
    ContentVisualInputModel? content,
    List<TicketInputModel>? tickets,
    String? status,
  }) async {
    try {
      final eventDate = DateTime.parse(eventDetail.dateController.text);

      final startTime =
          DateFormat.jm().parse(eventDetail.startTimeController.text);
      final endTime = DateFormat.jm().parse(eventDetail.endTimeController.text);

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

      Uint8List? compressedImageBytes;

      if (content?.userImage != null) {
        final imagePath = content!.userImage!.path;

        compressedImageBytes = await FlutterImageCompress.compressWithFile(
          imagePath,
          minWidth: 800, // You can adjust width/height as needed
          minHeight: 800,
          quality: 70, // 0 = max compression, 100 = best quality
          format: CompressFormat.jpeg,
        );
      }

      // Convert ticket info only if tickets are provided
      List<Map<String, dynamic>> ticketsJsonList = [];
      if (tickets != null) {
        ticketsJsonList = tickets.map((ticket) {
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
      }

      final modelData = {
        "name": eventDetail.titleController.text,
        "event_detail": content?.controller.document.toPlainText() ?? '',
        "datetime": eventDateTime.toUtc().toIso8601String(),
        "end_datetime": eventEndDateTime.toUtc().toIso8601String(),
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

      Logger().i('modelData: ${jsonEncode(modelData)}');
      Logger().i('Thumbnail path: ${content?.userImage?.path}');

      // Build form data
      final formMap = {
        "data": jsonEncode(modelData),
        'event_thumbnail': compressedImageBytes != null
      ? MultipartFile.fromBytes(
          compressedImageBytes,
          filename: content!.userImage!.path.split("/").last,
        )
      : null,
        "status": status ?? "waiting",
      };

      final formData = FormData.fromMap(formMap);

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
