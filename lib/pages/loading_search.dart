import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:outrain/services/weather_prediction.dart';
import 'dart:convert';
import 'package:outrain/services/world_time.dart';
import 'package:outrain/services/search_city.dart';

class LoadingSearch extends StatefulWidget {
  const LoadingSearch({Key? key}) : super(key: key);

  @override
  _LoadingSearchState createState() => _LoadingSearchState();
}

class _LoadingSearchState extends State<LoadingSearch> {

  Map data = {};

  void setupApplicationData() async {

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': data["pred"].getCity(0),
      'flag': data["time"].flag,
      'time': data["time"].time,
      'isDayTime': data["time"].isDayTime,
      'timeOfDay': data["time"].timeOfDay,
      'pred': data["pred"]
    });
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;

    if (data['success'] == false) {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Search Result'),
          centerTitle: true,
          elevation: 0,
        ),
        body: const Card(
          child: ListTile(
            title: Text(
                'City data is not avaiable :('
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Search Result'),
        centerTitle: true,
        elevation: 0,
      ),
      body: InkWell(
        onTap: () {
          setupApplicationData();
        },
        child: Card(
          child: ListTile(
            title: Text(
                data["pred"].getCity(0)
            ),
            subtitle: Text(
                data["pred"].getWeatherName(0)
            ),
            // leading: CircleAvatar(
            //   backgroundImage: AssetImage('assets/flags/${data["time"].flag}'),
            // ),
            trailing: Container(
              width: 160,
              child: Row(
                children: [
                  ClipRect(
                    child: Image(
                      image: NetworkImage('https://outrain-s3.s3.ap-southeast-1.amazonaws.com/png/${data["pred"].getWeatherAbbr(0)}.png'),
                    ),
                  ),
                  SizedBox(width: 10),
                  ClipRect(
                    child: Image(
                      image: AssetImage('assets/time_of_day_icon/${data["time"].timeOfDay}.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
