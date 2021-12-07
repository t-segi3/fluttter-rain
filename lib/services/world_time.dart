import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String? location; // location name for ui
  String time = 'fetching time..'; // time in that location
  String? flag; // url to flag asset
  String? url; // api location url
  bool? isDayTime; // true if daytime
  String timeOfDay = 'noon'; // time of day

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {

    try {
      // make request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));

      // decode
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];

      DateTime now = DateTime.parse(datetime.substring(0,26));

      // set time property on class
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

      if (now.hour > 3 && now.hour <=6) {
        timeOfDay = 'dusk';
      } else if (now.hour > 6 && now.hour <= 11) {
        timeOfDay = 'morning';
      } else if (now.hour > 11 && now.hour <= 15) {
        timeOfDay = 'noon';
      } else if (now.hour > 15 && now.hour <= 19) {
        timeOfDay = 'afternoon';
      } else if (now.hour > 19 && now.hour <= 20) {
        timeOfDay = 'dawn';
      } else if (now.hour > 20 && now.hour <=24 || now.hour < 3) {
        timeOfDay = 'night';
      }

    } catch (e) {
      print(e);
      time = 'could not get time data';
    }
  }

}