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

  Future<List<AQIList>> fetchHistoryAQI();

  Future<List<AQIList>> fetchForecastAQI();
}

class AQIRepositoryImpl implements AQIRepository {
  AQIRepositoryImpl(this._openweatherService, this._prefsService);

  final OpenweatherService _openweatherService;
  final SharedPrefsService _prefsService;

  @override
  Future<AQIList> fetchCurrentAQI() async {
    AQIList result = AQIList.empty();
    try {
      // final lastRawUpdate = _prefsService.getInt(lastCurrentUpdateKey) ?? 0;
      //
      // final ts = DateTime.fromMillisecondsSinceEpoch(lastRawUpdate);
      //
      // final toUpdate = shouldUpdateCurrent(ts);
      // final now = DateTime.now();
      // if (toUpdate) {
      result = await _fetchCurrentFromApi();
      // } else {
      //   result = await _fetchFromHive(key: currentKey);
      // }
      // _prefsService.setInt(lastCurrentUpdateKey, now.millisecondsSinceEpoch);
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

  @override
  Future<List<AQIList>> fetchForecastAQI() async {
    try {
      // final lastRawUpdate = _prefsService.getInt(lastForecastUpdateKey) ?? 0;

      // final ts = DateTime.fromMillisecondsSinceEpoch(lastRawUpdate);

      // final toUpdate = shouldUpdateGlobal(ts);
      // if (toUpdate) {
      return _fetchMultiAQIFromApi(lastForecastUpdateKey);
      // } else {
      // return _fetchFromHive(key: forecastKey);
      // }
    } catch (e) {
      log('Error in fetching forecast aqi: $e');
    }

    return [];
  }

  @override
  Future<List<AQIList>> fetchHistoryAQI() async {
    final resultList = <AQIList>[];
    try {
      // final lastRawUpdate = _prefsService.getInt(lastHistoryUpdateKey) ?? 0;
      //
      // final ts = DateTime.fromMillisecondsSinceEpoch(lastRawUpdate);
      //
      // final toUpdate = shouldUpdateGlobal(ts);
      // if (toUpdate) {
      return _fetchMultiAQIFromApi(lastHistoryUpdateKey);
      //
      // for (final list in temp) {
      //   final filteredList = <AQIData>[];
      //   for (int i = list.data.length - 1; i >= 0; i - 12) {
      //     filteredList.add(list.data[i]);
      //   }
      //   print(filteredList.length);
      //   resultList.add(AQIList.fromList(filteredList));
      // }

      // } else {
      //   return _fetchFromHive(key: historyKey);
      // }
    } catch (e) {
      log('Error in fetching history aqi: $e');
    }

    return resultList;
  }

  Future<List<AQIList>> _fetchMultiAQIFromApi(String saveKey) async {
    final result = <AQIList>[];

    try {
      final futures = <Future<AQIResponse?>>[];
      final now = DateTime.now();

      for (final location in locationsList) {
        if (saveKey == lastHistoryUpdateKey) {
          futures.add(
            _openweatherService.getAQIHistory(
              location: location,
              startDate: now.subtract(const Duration(days: 3)),
              endDate: now,
            ),
          );
        } else {
          futures.add(
            _openweatherService.getForecastAirQI(location: location),
          );
        }
      }

      final responses = await Future.wait(futures);

      _prefsService.setInt(lastHistoryUpdateKey, now.millisecondsSinceEpoch);

      for (int i = 0; i < responses.length; i++) {
        final response = responses[i];
        if (response?.data.isNotEmpty ?? false) {
          final mappedList = <AQIData>[];

          int index = 0;
          double co = 0;
          double no = 0;
          double no2 = 0;
          double o3 = 0;
          double so2 = 0;
          double pm2_5 = 0;
          double pm10 = 0;
          double nh3 = 0;

          int step = 0;
          for (int j = 0; j < response!.data.length; j++) {
            step++;
            final item = response.data[j];

            index += item.main.index;
            co += item.components.co;
            no += item.components.no;
            no2 += item.components.no2;
            o3 += item.components.o3;
            so2 += item.components.so2;
            pm2_5 += item.components.pm2_5;
            pm10 += item.components.pm10;
            nh3 += item.components.nh3;

            int remainder = step % 12;
            if (remainder == 0 || step == response.data.length) {
              int avg = remainder == 0 ? 12 : remainder;
              mappedList.add(
                AQIData(
                  location: locationsNames[i],
                  index: index ~/ avg,
                  co: co / avg,
                  no: no / avg,
                  no2: no2 / avg,
                  o3: o3 / avg,
                  so2: so2 / avg,
                  pm2_5: pm2_5 / avg,
                  pm10: pm10 / avg,
                  nh3: nh3 / avg,
                ),
              );

              index = 0;
              co = 0;
              no = 0;
              no2 = 0;
              o3 = 0;
              so2 = 0;
              pm2_5 = 0;
              pm10 = 0;
              nh3 = 0;
            }
          }
          result.add(AQIList.fromList(mappedList));
        }
      }
    } catch (e) {
      log('Error fetching from api: $e');
    }

    return result;
  }
}
