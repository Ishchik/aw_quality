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

  getIt.registerSingletonAsync<SharedPrefsService>(() async {
    final service = SharedPrefsService();
    await service.init();
    return service;
  });

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AW-KUALITI'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _onPressed() async {
    // final repo = OpenweatherApiRepositoryImpl();
    // final now = DateTime.now();

    // final futures = <Future<AQIData?>>[];
    // for(final location in locations){
    //   futures.add(
    //  final list = await   repo.getSingleLocationForecastAirQI(location: locations[2]);
    //   );
    // }


    // final results = await Future.wait(futures);
    //
    // for(int i = 0; i < 5; i++){
    //   log('${locations[i]} : index - ${results[i]?.index}');
    // }

    // final aqi = await repo.getAQIHistory(
    //   location: locationTes,
    //   startDate: now.subtract(const Duration(days: 5)),
    //   endDate: now,
    // );
  }
}
