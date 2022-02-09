import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

const List<Color> gradientColors = [
  Color(0xff23b6e6),
  Color(0xff02d39a),
];

enum DiagramType{
  aqi,
  so2,
  pm10,
  pm2_5,
  no2,
  co,
  o3,
}

class Diagram<T extends num> extends StatelessWidget {
  const Diagram({
    Key? key,
    required this.list,
    required this.maxY,
    required this.type,
  }) : super(key: key);

  final List<T> list;
  final double maxY;
  final DiagramType type;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
              showTitles: false,
              reservedSize: 22,
              interval: 1,
              getTextStyles: (context, value) => const TextStyle(
                    color: Color(0xff68737d),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
              margin: 8,
              getTitles: (value) {
                return 'NOW';
              }),
          leftTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff67727d),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            getTitles: _getTitles,
            reservedSize: 32,
            margin: 12,
          ),
        ),
        borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1)),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: _spots(),
            isCurved: true,
            colors: gradientColors,
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _spots() {
    final result = <FlSpot>[];
    for (int i = 0; i < list.length; i++) {
      result.add(FlSpot(i.toDouble(), double.parse(list[i].toStringAsFixed(2))));
    }

    return result;
  }

  String _getTitles(double value){
    switch(type){
      case DiagramType.aqi:
        switch (value.toInt()) {
          case 1:
            return '1';
          case 3:
            return '3';
          case 5:
            return '5';
        }
        break;
      case DiagramType.so2:
        switch (value.toInt()) {
          case 100:
            return '100';
          case 200:
            return '200';
          case 300:
            return '300';case 400:
            return '400';
        }
        break;
      case DiagramType.pm10:
        switch (value.toInt()) {
          case 30:
            return '30';
          case 60:
            return '60';
          case 90:
            return '90';
        }        break;
      case DiagramType.pm2_5:
        switch (value.toInt()) {
          case 20:
            return '20';
          case 40:
            return '40';
          case 60:
            return '60';
        }        break;
      case DiagramType.no2:
        switch (value.toInt()) {
          case 100:
            return '100';
          case 200:
            return '200';
          case 300:
            return '300';
        }        break;
      case DiagramType.co:
        switch (value.toInt()) {
          case 5:
            return '5';
          case 15:
            return '15';
          case 25:
            return '25';
        }        break;
      case DiagramType.o3:
        switch (value.toInt()) {
          case 60:
            return '60';
          case 120:
            return '120';
          case 180:
            return '180';
        }
        break;
    }
    return '';
  }
}
