import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/api/aqi_response.dart';
import '../models/common/location.dart';
import '../utils/query_params.dart';

const String _apitHost = 'api.openweathermap.org';
const String _apiPollution = '/data/2.5/air_pollution';
const String _apiPollutionHistory = '/data/2.5/air_pollution/history';
const String _apiPollutionForecast = '/data/2.5/air_pollution/forecast';
const String _apiKey = '826dcf940c3f6020e7901d06d85abd21';
const String _paramsAppID = 'appid';

abstract class OpenweatherService {
  Future<AQIResponse?> getSingleLocationAirQI({required Location location});

  Future<AQIResponse?> getSingleLocationForecastAirQI({
    required Location location,
  });

  Future<AQIResponse?> getAQIHistory({
    required Location location,
    required DateTime startDate,
    required DateTime endDate,
  });
}

class OpenweatherServiceImpl implements OpenweatherService {
  @override
  Future<AQIResponse?> getSingleLocationAirQI(
      {required Location location}) async {
    try {
      final Map<String, dynamic> params = location.toJson();
      params.putIfAbsent(_paramsAppID, () => _apiKey);

      final uri = Uri.https(
        _apitHost,
        _apiPollution,
        createUriParams(params),
      );

      log('$uri');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        log('Decoded response $decodedData');

        return AQIResponse.fromJson(decodedData);
      }
    } catch (e) {
      log('Error getting aqi: $e');
    }
    return null;
  }

  @override
  Future<AQIResponse?> getAQIHistory({
    required Location location,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final Map<String, dynamic> params = location.toJson();
      params
        ..putIfAbsent(
            'start', () => startDate.toUtc().millisecondsSinceEpoch ~/ 1000)
        ..putIfAbsent(
            'end', () => endDate.toUtc().millisecondsSinceEpoch ~/ 1000)
        ..putIfAbsent(_paramsAppID, () => _apiKey);

      final uri = Uri.https(
        _apitHost,
        _apiPollutionHistory,
        createUriParams(params),
      );

      log('$uri');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        log('$decodedData');
        return AQIResponse.fromJson(decodedData);
      }
    } catch (e) {
      log('Error getting aqi history: $e');
    }
    return null;
  }

  @override
  Future<AQIResponse?> getSingleLocationForecastAirQI({
    required Location location,
  }) async {
    try {
      final Map<String, dynamic> params = location.toJson();
      params.putIfAbsent(_paramsAppID, () => _apiKey);

      final uri = Uri.https(
        _apitHost,
        _apiPollutionForecast,
        createUriParams(params),
      );

      log('$uri');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        log('$decodedData');
        return AQIResponse.fromJson(decodedData);
      }
    } catch (e) {
      log('Error getting aqi forecast: $e');
    }
    return null;
  }
}
