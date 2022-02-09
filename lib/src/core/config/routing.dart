import 'package:aw_quality/src/ui/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../ui/screens/home/components/details_screen.dart';
import '../constants.dart';
import '../../ui/screens/home/home_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeRoute:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        settings: settings,
      );
    case detailsRoute:
      final args = settings.arguments as DetailsScreenArguments;
      return MaterialPageRoute(
        builder: (_) => DetailsScreen(
          location: args.location,
          list: args.list,
        ),
        settings: settings,
      );
    case splashRoute:
    default:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
        settings: settings,
      );
  }
}
