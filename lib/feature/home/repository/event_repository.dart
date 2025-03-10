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

  Future<List<EventModel>> getEventList() async {
    try {
      final response = await apiService.getApiData(dotenv.env['EVENT'] ?? "");

      List<dynamic> jsonData = response.data['data'];

      return jsonData
          .map((item) => EventModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e, stackTrace) {
      Logger().e('Error getSupplierInvoice: $e, stackTrace: $stackTrace');
      throw e;
    }
  }
}
