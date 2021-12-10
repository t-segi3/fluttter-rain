import 'package:flutter/material.dart';
import 'package:outrain/services/world_time.dart';
import 'package:outrain/services/weather_prediction.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  final textFieldValueHolder = TextEditingController();

  List<WorldTime> locations = [
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'), // jakarta
    WorldTime(url: 'Asia/Makassar', location: 'Denpasar', flag: 'indonesia.png'), // denpasar
    WorldTime(url: 'Asia/Singapore', location: 'Singapore', flag: 'singapore.png'), // singapore
    WorldTime(url: 'Asia/Kuala_Lumpur', location: 'Kuala Lumpur', flag: 'malaysia.png'), // kuala lumpur
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'united-states.png'), // new york
    WorldTime(url: 'America/Detroit', location: 'New York', flag: 'united-states.png'), // detroit
  ];

  List<WeatherPrediction> weatherPreds = [
    WeatherPrediction(woeid: '1047378'), // jakarta
    WeatherPrediction(woeid: '1047372'), // denpasar
    WeatherPrediction(woeid: '1062617'), // singapore
    WeatherPrediction(woeid: '1154781'), // kuala lumpur
    WeatherPrediction(woeid: '2459115'), // new york
    WeatherPrediction(woeid: '2391585'), // detroit
  ];

  void setupCity(int index) async {
    await locations[index].getTime();
    await weatherPreds[index].getPrediction();
  }

  void updateData(index) async {
    WorldTime instance = locations[index];

    // navigate to homescreen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
      'timeOfDay': instance.timeOfDay,
      'pred': weatherPreds[index]
    });
  }

  Future<Map> searchCityByName(String city) async {
    // try {
      Response response = await get(Uri.parse('http://10.0.2.2:3000/api/searchByCity?city=$city'));

      // decode
      Map searchData = jsonDecode(response.body);

      // print(searchData);

      if (searchData["success"] == false) {
        return searchData;
      }

      searchData["pred"] = WeatherPrediction(woeid: "${searchData["woeid"]}");
      searchData["time"] = WorldTime(url: searchData["timezone"], location: city, flag: 'indonesia.png');

      await searchData["pred"].getPrediction();
      await searchData["time"].getTime();

      return searchData;
    // } catch (e) {
    //   print(e);
    // }
    //
    // return {};
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('choose location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textFieldValueHolder,
                ),
              ),
              FlatButton(
                child: const Text(
                  'Search',
                  style: TextStyle(fontSize: 20.0),
                ),
                onPressed: () async {

                  Map cityData = await searchCityByName(textFieldValueHolder.text);

                  print(cityData);

                  await Navigator.pushNamed(context, '/search-loading', arguments: {
                    'success': cityData["success"],
                    'country': cityData["country"],
                    'timezone': cityData["timezone"],
                    'pred': cityData["pred"],
                    'time': cityData["time"]
                  });

                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       content: Text(textFieldValueHolder.text),
                  //     );
                  //   }
                  // );
                },
              ),
            ],
          ),
          Expanded(child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: weatherPreds.length,
            itemExtent: 90,
            itemBuilder: (context, index) {
              return FutureBuilder(
                future: Future.wait([weatherPreds[index].getPrediction(), locations[index].getTime()]),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      // padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                      child: SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                    child: Card(
                      child: ListTile(
                        onTap: () async {
                          updateData(index);
                        },
                        title: Text(
                            weatherPreds[index].getCity(0)
                        ),
                        subtitle: Text(
                            weatherPreds[index].getWeatherName(0)
                        ),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/flags/${locations[index].flag}'),
                        ),
                        trailing: Container(
                          width: 160,
                          child: Row(
                            children: [
                              ClipRect(
                                child: Image(
                                  image: AssetImage('assets/weather_icons/png/${weatherPreds[index].getWeatherAbbr(0)}.png'),
                                ),
                              ),
                              SizedBox(width: 10),
                              ClipRect(
                                child: Image(
                                  image: AssetImage('assets/time_of_day_icon/${locations[index].timeOfDay}.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),),
        ],
      )
    );
  }
}
