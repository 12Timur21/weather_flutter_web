import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/weather_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherApi {
  WeatherApi._();
  static WeatherApi instance = WeatherApi._();

  Future<WeatherModel> getWeather({
    required double lat,
    required double lon,
  }) async {
    String appID = dotenv.env['WEATHER_API_KEY']!;

    Response<Map<String, dynamic>> response = await Dio().get(
      'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude={hourly,daily}&appid=$appID&units=metric',
    );

    if (response.data != null) {
      return WeatherModel.fromJson(response.data!);
    } else {
      throw Exception('No response');
    }
  }
}
