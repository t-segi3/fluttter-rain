// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:outrain/utils/geo_helper.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String datenow = DateFormat('dd MMMM yyyy').format(DateTime.now());
  String location ='Null, Press Button';
  String city = "Loading..";

  GeoHelper gh = GeoHelper();

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //     colors: [Color(0xff15a7f1), Color(0xff062E42)],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter
        // ),
        image: DecorationImage(
          image: AssetImage('assets/time_of_day_bg/${data['timeOfDay']}.png'),
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
          fit: BoxFit.cover,
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
                Center(
                  child: FlatButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');

                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'flag': result['flag'],
                          'isDayTime': result['isDayTime'],
                          'timeOfDay': result['timeOfDay'],
                          'pred': result['pred']
                        };
                        print(data['pred'].getWeatherAbbr(0));
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                      '${data['pred'].getCity(0)}',
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 18.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Image(
                    image: NetworkImage('https://outrain-s3.s3.ap-southeast-1.amazonaws.com/png/${data['pred'].getWeatherAbbr(0)}.png'),
                    height: 200,
                    width: 200,
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Text(
                    data['pred'].getWeatherName(0),
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
                    '${data['pred'].getTemp(0)}°',
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
                          '${data['pred'].getWindSpeed(0)} mph',
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
                          '${data['pred'].getHumidity(0)}%',
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
                          '${data['pred'].getVisibility(0)} miles',
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
                          '${data['pred'].getPredictability(0)}%',
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
