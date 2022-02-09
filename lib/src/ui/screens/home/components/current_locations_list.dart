import 'package:flutter/material.dart';

import '../../../../core/models/common/aqi_data.dart';

class CurrentLocationsList extends StatelessWidget {
  const CurrentLocationsList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<AQIData> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        final item = list[index];

        return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 120.0),
          child: Card(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.location,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 36.0),
                      Text('AQI: ${item.index}'),
                    ],
                  ),
                ),
                Container(
                  height: 100.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  child: VerticalDivider(
                    width: 2.0,
                    color: Colors.grey[400],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text('SO2: ${item.so2}'),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text('PM10: ${item.pm10}'),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text('PM2.5: ${item.pm2_5}'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text('NO2: ${item.no2}'),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text('CO: ${item.co}'),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text('O3: ${item.o3}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
