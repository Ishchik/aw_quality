import 'package:hive/hive.dart';

import 'aqi_hive_model.dart';

part 'aqi_data_list_hive_model.g.dart';

@HiveType(typeId: 1)
class AQIDataListHiveModel {
  AQIDataListHiveModel({
    this.data = const [],
  });

  @HiveField(0, defaultValue: <AQIHiveModel>[])
  final List<AQIHiveModel> data;
}
