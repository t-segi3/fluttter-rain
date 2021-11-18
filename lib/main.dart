// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'utils/geo_helper.dart';

void main() {
  runApp(MaterialApp(
    home: HomeCard(),
  ));
}

class HomeCard extends StatefulWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {

  String datenow = DateFormat('dd MMMM yyyy').format(DateTime.now());
  String location ='Null, Press Button';
  String city = "Jakarta";

  GeoHelper gh = GeoHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff15a7f1), Color(0xff062E42)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   title: Text('OutRain'),
          //   centerTitle: true,
          //   backgroundColor: Colors.grey[850],
          //   elevation: 0,
          // ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Position position = await gh.getLatLong();
              location ='Lat: ${position.latitude} , Long: ${position.longitude}';
              print(location);
              // setState((){
              //   city = location;
              // });
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.grey[800],
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
            margin: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '${city}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 18.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Image(
                    image: NetworkImage('https://outrain-s3.s3.ap-southeast-1.amazonaws.com/png/sn.png'),
                    height: 200,
                    width: 200,
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Text(
                    'CERAH',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2.0,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Text(
                    '32°',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2.0,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Center(
                  child: Text(
                    // '1 November 2021',
                    '${datenow}',
                    style: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                Divider(
                  height: 60.0,
                  color: Colors.white38,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.air,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          '6.5 mph',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Wind',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.water_rounded,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          '70%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Humidity',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          '8.7 miles',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Visibility',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.auto_fix_high,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          '70%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Prediction',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}




