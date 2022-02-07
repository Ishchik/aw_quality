import 'dart:developer';

import 'package:aw_quality/src/core/models/hive/aqi_data_list_hive_model.dart';
import 'package:aw_quality/src/core/services/openweather_service.dart';
import 'package:aw_quality/src/core/services/shared_prefs_service.dart';
import 'package:hive/hive.dart';

import '../constants.dart';
import '../models/api/aqi_response.dart';
import '../models/common/aqi_data.dart';
import '../utils/update_checker.dart';

abstract class AQIRepository {
  Future<AQIList> fetchCurrentAQI();

  Future<AQIList> fetchHistoryAQI();

  Future<AQIList> fetchForecastAQI();
}

class AQIRepositoryImpl implements AQIRepository {
  AQIRepositoryImpl(this._openweatherService, this._prefsService);

  final OpenweatherService _openweatherService;
  final SharedPrefsService _prefsService;

  @override
  Future<AQIList> fetchCurrentAQI() async {
    AQIList result = AQIList.empty();
    try {
      final lastRawUpdate = _prefsService.getInt(lastCurrentUpdateKey) ?? 0;

      final ts = DateTime.fromMillisecondsSinceEpoch(lastRawUpdate);

      final toUpdate = shouldUpdateCurrent(ts);
      final now = DateTime.now();
      if (toUpdate) {
        result = await _fetchCurrentFromApi();
      } else {
        result = await _fetchFromHive(key: currentKey);
      }
      _prefsService.setInt(lastCurrentUpdateKey, now.millisecondsSinceEpoch);
    } catch (e) {
      log('Error in fetching current aqi: $e');
    }

    return result;
  }

  Future<AQIList> _fetchCurrentFromApi() async {
    final resultList = <AQIData>[];

    try {
      final futures = <Future<AQIResponse?>>[];
      for (final location in locationsList) {
        futures.add(
          _openweatherService.getSingleLocationAirQI(location: location),
        );
      }

      final responses = await Future.wait(futures);

      final now = DateTime.now();
      _prefsService.setInt(lastCurrentUpdateKey, now.millisecondsSinceEpoch);

      for (int i = 0; i < responses.length; i++) {
        final response = responses[i];
        if (response?.data.isNotEmpty ?? false) {
          final responseData = response!.data.first;
          final data = AQIData(
            location: locationsNames[i],
            index: responseData.main.index,
            dateTime: responseData.timestamp,
            co: responseData.components.co,
            no: responseData.components.no,
            no2: responseData.components.no2,
            o3: responseData.components.o3,
            so2: responseData.components.so2,
            pm2_5: responseData.components.pm2_5,
            pm10: responseData.components.pm10,
            nh3: responseData.components.nh3,
          );
          resultList.add(data);
        }
      }
    } catch (e) {
      log('Error in fetching current aqi from API: $e');
    }
    final result = AQIList.fromList(resultList);

    return result;
  }

  Future<AQIList> _fetchFromHive({required dynamic key}) async {
    final box = await Hive.openBox<AQIDataListHiveModel>(hiveBox);
    final hiveModel = box.get(key, defaultValue: AQIDataListHiveModel())!;

    final mappedList = hiveModel.data
        .map(
          (e) => AQIData(
            location: e.location,
            index: e.index,
            dateTime: DateTime.fromMillisecondsSinceEpoch(e.timestamp),
            co: e.co,
            no: e.no,
            no2: e.no2,
            o3: e.o3,
            so2: e.so2,
            pm2_5: e.pm2_5,
            pm10: e.pm10,
            nh3: e.nh3,
          ),
        )
        .toList();

    return AQIList.fromList(mappedList);
  }

  @override
  Future<AQIList> fetchForecastAQI() async {
    try {
      final lastRawUpdate = _prefsService.getInt(lastForecastUpdateKey) ?? 0;

      final ts = DateTime.fromMillisecondsSinceEpoch(lastRawUpdate);

      final toUpdate = shouldUpdateGlobal(ts);
      if (toUpdate) {
        return _fetchCurrentFromApi();
      } else {
        return _fetchFromHive(key: forecastKey);
      }
    } catch (e) {
      log('Error in fetching forecast aqi: $e');
    }

    return AQIList.empty();
  }

  @override
  Future<AQIList> fetchHistoryAQI() async {
    try {
      final lastRawUpdate = _prefsService.getInt(lastHistoryUpdateKey) ?? 0;

      final ts = DateTime.fromMillisecondsSinceEpoch(lastRawUpdate);

      final toUpdate = shouldUpdateGlobal(ts);
      if (toUpdate) {
        // return _fetchCurrentFromApi();
      } else {
        return _fetchFromHive(key: historyKey);
      }
    } catch (e) {
      log('Error in fetching history aqi: $e');
    }

    return AQIList.empty();
  }
}
