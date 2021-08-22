import 'dart:convert';

import 'package:http/http.dart' as http;
import './models.dart';

class FetchData {
  Future<WeatherResponse> getWeather(String city) async {
    //api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameter = {
      'q': city,
      'appid': '32517a03b4f94409673cda076ec97153',
      'units': 'metric'
    };

    final url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      queryParameter,
    );

    final response = await http.get(url);
    print(response.body);
    final jsonn = jsonDecode(response.body);
    return WeatherResponse.fromJson(jsonn);
  }
}
