import 'package:dio/dio.dart';
import 'package:event_radar2/network/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class ApiService {
  final SecureStorageService secureStorageService;

  ApiService({required this.secureStorageService});

  final String _baseUrl = dotenv.env['BASE_URL']!;

  final Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  ));

  String? token;

  // Create a logger instance
  final Logger _logger = Logger();

  Future<Options> _getAuthOptions() async {
    final token = await secureStorageService.getSessionToken();
    debugPrint("token: $token");
    return Options(headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
  }

  Future<Response<dynamic>> getApiData(String urlServicesName,
      {Map<String, dynamic>? queryParams, bool? isLogin}) async {
    try {
      _logger
          .i("getApiData to ${urlServicesName} with queryParam: $queryParams");

      final options = await _getAuthOptions();
      final response = await dio.get(
        _baseUrl + urlServicesName,
        options: options,
        queryParameters: queryParams,
      );
      _logger.i(
          'GET request to $urlServicesName successful with response ${response.data}');
      return response;
    } on DioException catch (e) {
      _logger.e('DioError on GET request to $urlServicesName: $e');
      throw Exception(
          "${e.response?.statusCode} - ${e.response?.data != null ? e.response?.data is Map<String, dynamic> ? (() {
              final error = e.response?.data;

              if (error != null) {
                if (error.toString().toLowerCase().contains('timeout')) {
                  return 'Something went wrong. Please Try again later';
                }
                return error;
              } else if (error != null) {
                if (error.toString().toLowerCase().contains('timeout')) {
                  return 'Something went wrong. Please Try again later';
                }
                return error;
              } else {
                return 'Something went wrong. Please Try again later';
              }
            })() : (e.response?.data.toString().contains(':') ?? false) ? e.response?.data.toString().split(':').skip(1).join(':').trim() : e.response?.data.toString() : 'Something went wrong. Please Try again later'}");
    } catch (e) {
      _logger.e('Unexpected error on GET request to $urlServicesName: $e');
      rethrow;
    }
  }

  Future<Response<dynamic>> postApiDataWithToken(
      String urlServicesName, Object? modelData) async {
    try {
      _logger.i(
          "postApiDataWithToken to ${_baseUrl}${urlServicesName} with modelData: ${modelData}");
      final options = await _getAuthOptions();
      final response = await dio.post(_baseUrl + urlServicesName,
          options: options, data: modelData);

      _logger.i(
          'POST request to $urlServicesName with token successful. with response ${response.data}');
      return response;
    } on DioException catch (e) {
      _logger.e('DioError on POST request to $urlServicesName: $e');
      throw Exception("${e.response?.statusCode} - $e");
    } catch (e) {
      _logger.e('Unexpected error on POST request to $urlServicesName: $e');
      rethrow;
    }
  }

  Future<Response<dynamic>> postApiDataWithTokenReportLive(
      String urlServicesName, Object? modelData) async {
    debugPrint("postApiDataWithToken modelData: $modelData");

    try {
      _logger.i(
          "postApiDataWithToken to ${urlServicesName} with modelData: $modelData");
      final options = await _getAuthOptions();
      final response = await dio.post(
          'https://idms-api-report-testing.indomobil.co.id/' + urlServicesName,
          options: options,
          data: modelData);

      _logger.i(
          'POST request to $urlServicesName with token successful. with response ${response.data}');
      return response;
    } on DioException catch (e) {
      _logger.e('DioError on POST request to $urlServicesName: $e');
      throw Exception("${e.response?.statusCode} - $e");
    } catch (e) {
      _logger.e('Unexpected error on POST request to $urlServicesName: $e');
      rethrow;
    }
  }

  Future<Response<dynamic>> postApiDataWithoutToken(
      String urlServicesName, Object? modelData) async {
    try {
      _logger.i(
          "postApiDataWithoutToken to ${_baseUrl}${urlServicesName} with modelData: $modelData");

      final response =
          await dio.post(_baseUrl + urlServicesName, data: modelData);
      _logger.i(
          'POST request to $urlServicesName without token successful. with response ${response.data}');
      return response;
    } on DioException catch (e) {
      _logger.e('DioError on POST request to $urlServicesName: $e');
      throw Exception("${e.response?.statusCode} - $e");
    } catch (e) {
      _logger.e('Unexpected error on POST request to $urlServicesName: $e');
      rethrow;
    }
  }

  Future<Response<dynamic>> putApiData(
      String urlServicesName, Object? modelData) async {
    try {
      _logger.i("putApiData to ${urlServicesName} with modelData: $modelData");

      final options = await _getAuthOptions();
      final response = await dio.put(_baseUrl + urlServicesName,
          options: options, data: modelData);
      _logger.i('PUT request to $urlServicesName successful.');
      return response;
    } on DioException catch (e) {
      _logger.e('DioError on PUT request to $urlServicesName: $e');
      throw Exception("${e.response?.statusCode} - $e");
    } catch (e) {
      _logger.e('Unexpected error on PUT request to $urlServicesName: $e');
      rethrow;
    }
  }

  Future<Response<dynamic>> putApiDataWithoutToken(
      String urlServicesName, Object? modelData) async {
    try {
      _logger.i(
          "putApiDataWithoutToken to ${urlServicesName} with modelData: $modelData");

      final response =
          await dio.put(_baseUrl + urlServicesName, data: modelData);
      _logger.i(
          'PUT request to $urlServicesName successful. with response ${response.data}');
      return response;
    } on DioException catch (e) {
      _logger.e('DioError on PUT request to $urlServicesName: $e');
      throw Exception("${e.response?.statusCode} - $e");
    } catch (e) {
      _logger.e('Unexpected error on PUT request to $urlServicesName: $e');
      rethrow;
    }
  }

  Future<Response<dynamic>> deleteApiDataWithToken(
      String urlServicesName, Object? modelData) async {
    try {
      _logger.i(
          "deleteApiDataWithToken to ${urlServicesName} with modelData: $modelData");

      final options = await _getAuthOptions();

      final response = await dio.delete(_baseUrl + urlServicesName,
          data: modelData, options: options);
      _logger.i(
          'DELETE request to $urlServicesName successful. with response ${response.data}');
      return response;
    } on DioException catch (e) {
      _logger.e('DioError on DELETE request to $urlServicesName: $e');
      throw Exception("${e.response?.statusCode} - $e");
    } catch (e) {
      _logger.e('Unexpected error on DELETE request to $urlServicesName: $e');
      rethrow;
    }
  }
}
