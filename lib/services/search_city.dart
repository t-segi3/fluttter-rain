import 'package:http/http.dart';
import 'dart:convert';

class SearchCity {

  Future<Map> searchCityByName(String city) async {

    try {
      Response response = await get(Uri.parse('http://10.0.2.2:3000/api/searchByCity?city=$city'));

      // decode
      Map data = jsonDecode(response.body);
      print(data);

      return data;
    } catch (e) {
      print(e);
    }

    return {};
  }
}