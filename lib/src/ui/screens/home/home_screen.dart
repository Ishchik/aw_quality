import 'package:aw_quality/src/ui/screens/home/components/current_aqi_page.dart';
import 'package:aw_quality/src/ui/screens/home/components/history_page.dart';
import 'package:flutter/material.dart';

import 'components/forecast_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const pages = <Widget>[
  CurrentAQIPage(),
  HistoryPage(),
  ForecastPage(),
];

class _HomeScreenState extends State<HomeScreen> {
  int index = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('AW-KUALITI'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (index) => setState(() {
          this.index = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse_rounded),
            label: 'Current',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.broken_image),
            label: 'Forecast',
          ),
        ],
      ),
      body: SafeArea(
        child: pages[index],
      ),
    );
  }
}
