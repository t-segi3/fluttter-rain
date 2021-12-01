import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WeatherPrediction {

  String? startDate; // prediction start date
  String? endDate; // prediction end date
  String? woeid; // lcoation woeid
  List predictions = []; // prediction object

  WeatherPrediction({ this.woeid });

  Future<void> getPrediction() async {

    try {
      // make request
      Response response = await get(Uri.parse('http://10.0.2.2:3000/api/getPrediction?woeid=$woeid'));

      // decode
      Map data = jsonDecode(response.body);
      predictions = data['data'];

    } catch (e) {
      print('failed to fetch weather predictions');
      print(e);
    }
  }

  String getApplicableDate(int index) {
      return predictions[index]['consolidated_weather']['applicable_date'];
  }

  String getWeatherName(int index) {
    return predictions[index]['consolidated_weather']['weather_state_name'];
  }

  String getWeatherAbbr(int index) {
    return predictions[index]['consolidated_weather']['weather_state_abbr'];
  }

  String getMinTemp(int index) {
    return predictions[index]['consolidated_weather']['min_temp'];
  }

  String getMaxTemp(int index) {
    return predictions[index]['consolidated_weather']['max_temp'];
  }

  String getTemp(int index) {
    var temp = predictions[index]['consolidated_weather']['the_temp'];
    return temp.toStringAsFixed(1);
  }

  String getVisibility(int index) {
    return predictions[index]['consolidated_weather']['visibility'].toStringAsFixed(1);
  }

  String getWindSpeed(int index) {
    return predictions[index]['consolidated_weather']['wind_speed'].toStringAsFixed(1);
  }

  String getWindDirection(int index) {
    return predictions[index]['consolidated_weather']['wind_direction'];
  }

  String getWindDirectionCompass(int index) {
    return predictions[index]['consolidated_weather']['wind_direction_compass'];
  }

  String getHumidity(int index) {
    return predictions[index]['consolidated_weather']['humidity'].toStringAsFixed(0);
  }

  String getPredictability(int index) {
    return predictions[index]['consolidated_weather']['predictability'].toString();
  }

}