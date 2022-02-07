// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aqi_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AQIResponse _$AQIResponseFromJson(Map<String, dynamic> json) => AQIResponse(
      coordinates: Location.fromJson(json['coord'] as Map<String, dynamic>),
      data: (json['list'] as List<dynamic>)
          .map((e) => AQIResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AQIResponseData _$AQIResponseDataFromJson(Map<String, dynamic> json) =>
    AQIResponseData(
      timestamp: AQIResponseData._parseTimestamp(json['dt'] as int),
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      components:
          Components.fromJson(json['components'] as Map<String, dynamic>),
    );

Main _$MainFromJson(Map<String, dynamic> json) => Main(
      index: json['aqi'] as int,
    );

Components _$ComponentsFromJson(Map<String, dynamic> json) => Components(
      co: (json['co'] as num).toDouble(),
      no: (json['no'] as num).toDouble(),
      no2: (json['no2'] as num).toDouble(),
      o3: (json['o3'] as num).toDouble(),
      so2: (json['so2'] as num).toDouble(),
      pm2_5: (json['pm2_5'] as num).toDouble(),
      pm10: (json['pm10'] as num).toDouble(),
      nh3: (json['nh3'] as num).toDouble(),
    );
