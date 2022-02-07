import 'package:json_annotation/json_annotation.dart';

import '../common/location.dart';

part 'aqi_response.g.dart';

/*
{
  "coord":[
    50,
    50
  ],
  "list":[
    {
      "dt":1605182400,
      "main":{
        "aqi":1
      },
      "components":{
        "co":201.94053649902344,
        "no":0.01877197064459324,
        "no2":0.7711350917816162,
        "o3":68.66455078125,
        "so2":0.6407499313354492,
        "pm2_5":0.5,
        "pm10":0.540438711643219,
        "nh3":0.12369127571582794
      }
    }
  ]
}
*/

@JsonSerializable(createToJson: false)
class AQIResponse {
  AQIResponse({
    required this.coordinates,
    required this.data,
  });

  factory AQIResponse.fromJson(Map<String, dynamic> json) =>
      _$AQIResponseFromJson(json);

  @JsonKey(name: 'coord')
  final Location coordinates;
  @JsonKey(name: 'list')
  final List<AQIResponseData> data;
}

@JsonSerializable(createToJson: false)
class AQIResponseData {
  AQIResponseData({
    required this.timestamp,
    required this.main,
    required this.components,
  });

  factory AQIResponseData.fromJson(Map<String, dynamic> json) =>
      _$AQIResponseDataFromJson(json);

  @JsonKey(name: 'dt', fromJson: _parseTimestamp)
  final DateTime timestamp;
  final Main main;
  final Components components;

  static DateTime _parseTimestamp(int ts) =>
      DateTime.fromMillisecondsSinceEpoch(ts * 1000, isUtc: true);
}

@JsonSerializable(createToJson: false)
class Main {
  Main({required this.index});

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);

  @JsonKey(name: 'aqi')
  final int index;
}

@JsonSerializable(createToJson: false)
class Components {
  Components({
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
  });

  factory Components.fromJson(Map<String, dynamic> json) =>
      _$ComponentsFromJson(json);

  final double co;
  final double no;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final double nh3;
}
