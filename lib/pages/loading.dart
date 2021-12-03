import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:outrain/services/weather_prediction.dart';
import 'dart:convert';
import 'package:outrain/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupApplicationData() async {
    WorldTime waktu = WorldTime(location: 'Jakarta', flag: 'indonesian.png', url: 'Asia/Jakarta');
    await waktu.getTime();

    WeatherPrediction pred = WeatherPrediction(woeid: '1047372');
    await pred.getPrediction();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': waktu.location,
      'flag': waktu.flag,
      'time': waktu.time,
      'isDayTime': waktu.isDayTime,
      'pred': pred
    });
  }

  @override
  void initState() {
    super.initState();

    setupApplicationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: const SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
