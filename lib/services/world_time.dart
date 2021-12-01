import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String? location; // location name for ui
  String time = 'fetching time..'; // time in that location
  String? flag; // url to flag asset
  String? url; // api location url
  bool? isDayTime; // true if daytime

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
    } catch (e) {
      print(e);
      time = 'could not get time data';
    }
  }

}