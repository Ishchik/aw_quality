import 'package:hive/hive.dart';

part 'aqi_hive_model.g.dart';

@HiveType(typeId: 0)
class AQIHiveModel extends HiveObject {
  AQIHiveModel({
    required this.location,
    required this.index,
    required this.timestamp,
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
  });

  @HiveField(0, defaultValue: '')
  final String location;
  @HiveField(1, defaultValue: 0)
  final int index;
  @HiveField(2, defaultValue: 0)
  final int timestamp;
  @HiveField(3, defaultValue: 0.0)
  final double co;
  @HiveField(4, defaultValue: 0.0)
  final double no;
  @HiveField(5, defaultValue: 0.0)
  final double no2;
  @HiveField(6, defaultValue: 0.0)
  final double o3;
  @HiveField(7, defaultValue: 0.0)
  final double so2;
  @HiveField(8, defaultValue: 0.0)
  final double pm2_5;
  @HiveField(9, defaultValue: 0.0)
  final double pm10;
  @HiveField(10, defaultValue: 0.0)
  final double nh3;
}
