import 'package:event_radar2/feature/home/data/ad_slider_model.dart';
import 'package:event_radar2/network/api_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class AdsliderRepository {
  final ApiService apiService;

  AdsliderRepository({required this.apiService});

  final Logger _logger = Logger();

  Future<List<AdSliderModel>> getAdSliderList() async {
    try {
      final response = await apiService.getApiData(dotenv.env['AD_SLIDER']!);

      List<dynamic> jsonData = response.data['data'];

      return jsonData
          .map(
              (item) => AdSliderModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e, stackTrace) {
      _logger.e('Error getAdSliderList: $e', stackTrace: stackTrace);
      throw e;
    }
  }
}
