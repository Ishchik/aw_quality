import 'package:aw_quality/src/core/models/common/aqi_data.dart';
import 'package:aw_quality/src/ui/common/diagram_tile.dart';
import 'package:flutter/material.dart';

import '../../../common/diagram.dart';

class DetailsScreenArguments {
  DetailsScreenArguments({
    required this.location,
    required this.list,
  });

  final String location;
  final List<AQIData> list;
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.location,
    required this.list,
  }) : super(key: key);

  final String location;
  final List<AQIData> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            DiagramTile(
              list: list.map((e) => e.so2).toList(),
              title: 'SO2',
              maxY: 500,
              type: DiagramType.so2,
            ),
            DiagramTile(
              list: list.map((e) => e.so2).toList(),
              title: 'PM10',
              maxY: 100,
              type: DiagramType.pm10,
            ),
            DiagramTile(
              list: list.map((e) => e.so2).toList(),
              title: 'PM2.5',
              maxY: 60,
              type: DiagramType.pm2_5,
            ),
            DiagramTile(
              list: list.map((e) => e.so2).toList(),
              title: 'NO2',
              maxY: 400,
              type: DiagramType.no2,
            ),
            DiagramTile(
              list: list.map((e) => e.so2).toList(),
              title: 'CO',
              maxY: 30,
              type: DiagramType.co,
            ),
            DiagramTile(
              list: list.map((e) => e.so2).toList(),
              title: 'O3',
              maxY: 240,
              type: DiagramType.o3,
            ),
          ],
        ),
      ),
    );
  }
}
