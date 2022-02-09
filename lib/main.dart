import 'package:aw_quality/src/core/config/routing.dart';
import 'package:aw_quality/src/core/constants.dart';
import 'package:aw_quality/src/core/repositories/aqi_repository.dart';
import 'package:aw_quality/src/core/services/openweather_service.dart';
import 'package:aw_quality/src/core/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/core/models/hive/aqi_data_list_hive_model.dart';
import 'src/core/models/hive/aqi_hive_model.dart';

final GetIt getIt = GetIt.instance;

Future<void> main() async{
  await Hive.initFlutter();

  Hive.registerAdapter(AQIHiveModelAdapter());
  Hive.registerAdapter(AQIDataListHiveModelAdapter());

  Hive.openBox(hiveBox);

  getIt.registerSingleton<SharedPrefsService>(SharedPrefsService());

  getIt.get<SharedPrefsService>().init();

  getIt.registerFactory<OpenweatherService>(() => OpenweatherServiceImpl());

  getIt.registerFactory<AQIRepository>(() => AQIRepositoryImpl(
    getIt.get<OpenweatherService>(),
    getIt.get<SharedPrefsService>(),
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AW-KUALITI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: splashRoute,
      onGenerateRoute: onGenerateRoute,
    );
  }
}