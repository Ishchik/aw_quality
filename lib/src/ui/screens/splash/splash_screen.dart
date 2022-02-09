import 'package:aw_quality/src/core/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
      () => WidgetsBinding.instance?.addPostFrameCallback(
        (timeStamp) {
          Navigator.of(context).pushReplacementNamed(homeRoute);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Hello there :D',
                style: TextStyle(fontSize: 24.0),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
