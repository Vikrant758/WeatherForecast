import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_application/views/sign_in.dart';
import 'package:flutter_weather_application/views/sign_up.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/open_weather_controller.dart';
import '../models/credentials.dart';
import '../services/open_weather_service/open_weather_service.dart';
import '../utils/utils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  OpenWeatherController controller = Get.put(OpenWeatherController());

  void _incrementCounter() async {
    Utils.getLatLong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard "),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () async{
                controller.getCurrentDayForecastReport();
              },
              child: const Text('Forecast for current day'),
            ),
            const SizedBox(width: 30),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Get.offAll(() => const SignIn());
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
