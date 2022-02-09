import 'package:aw_quality/src/core/constants.dart';
import 'package:aw_quality/src/core/models/common/aqi_data.dart';
import 'package:aw_quality/src/ui/common/diagram.dart';
import 'package:aw_quality/src/ui/common/diagram_tile.dart';
import 'package:aw_quality/src/ui/screens/home/components/details_screen.dart';
import 'package:flutter/material.dart';

class AQIDiagramList extends StatelessWidget {
  const AQIDiagramList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<AQIList> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        final item = list[index];

        final data = item.data;
        if (data.isNotEmpty) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                detailsRoute,
                arguments: DetailsScreenArguments(
                  location: data.first.location,
                  list: data,
                ),
              );
            },
            child: DiagramTile(
              list: data.map((e) => e.index).toList(),
              title: data.first.location,
              maxY: 6,
              type: DiagramType.aqi,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
