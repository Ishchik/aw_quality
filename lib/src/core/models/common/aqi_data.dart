class AQIList {
  factory AQIList.fromList(List<AQIData> list) => AQIList._(list);

  factory AQIList.empty() => AQIList._([]);

  AQIList._(this.data);

  final List<AQIData> data;
}

class AQIData {
  AQIData({
    required this.location,
    required this.index,
    required this.dateTime,
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
  });

  final String location;
  final int index;
  final DateTime dateTime;
  final double co;
  final double no;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final double nh3;
}
