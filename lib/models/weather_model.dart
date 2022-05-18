import 'package:flutter_application_1/models/place_card_model.dart';

class WeatherModel {
  final PlaceLocation? location;
  final String timezone;
  final int timezoneOffset;
  final Current current;
  final List<Hourly> hourly;
  final List<Daily> daily;

  WeatherModel({
    required this.location,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    List<Hourly> hourly = [];
    json['hourly'].forEach((v) {
      hourly.add(
        Hourly.fromJson(v),
      );
    });

    List<Daily> daily = [];
    json['daily'].forEach((v) {
      daily.add(
        Daily.fromJson(v),
      );
    });

    return WeatherModel(
      location: PlaceLocation(
        lat: json['lat'],
        lng: json['lon'],
      ),
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current: Current.fromJson(json['current']),
      hourly: hourly,
      daily: daily,
    );
  }
}

//TODO Есди нужно, то добавить осадок снега и дождя

class Current {
  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;

  final int humidity;

  final int clouds;

  final double? windSpeed;
  final int windDeg;
  final double? windGust;
  final List<Weather> weather;

  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.clouds,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    List<Weather> weather = [];
    json['weather'].forEach((v) {
      weather.add(
        Weather.fromJson(v),
      );
    });

    return Current(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      temp: json['temp'],
      feelsLike: json['feels_like'],
      humidity: json['humidity'],
      clouds: json['clouds'],
      windSpeed: json['wind_speed'],
      windDeg: json['wind_deg'],
      windGust: json['wind_gust'],
      weather: weather,
    );
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  const Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class Hourly {
  final int dt;
  final double temp;
  final double feelsLike;
  final int humidity;
  final int clouds;
  final double windSpeed;
  final int windDeg;
  final double? windGust;
  final List<Weather> weather;
  final double? pop;

  const Hourly({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.clouds,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.pop,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    List<Weather> weather = [];
    json['weather'].forEach((v) {
      weather.add(Weather.fromJson(v));
    });

    return Hourly(
      dt: json['dt'],
      temp: json['temp'],
      feelsLike: json['feels_like'],
      humidity: json['humidity'],
      clouds: json['clouds'],
      windSpeed: json['wind_speed'],
      windDeg: json['wind_deg'],
      windGust: json['wind_gust'],
      weather: weather,
      pop: json['pop'],
    );
  }
}

class Daily {
  final int dt;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final double? moonPhase;
  final Temp? temp;
  final FeelsLike? feelsLike;

  final int humidity;
  final double? windSpeed;
  final int? windDeg;
  final double? windGust;
  final List<Weather>? weather;
  final int clouds;
  final double? rain;
  final double? snow;
  final double? pop;

  const Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.rain,
    required this.snow,
    required this.pop,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    List<Weather> weather = [];
    json['weather'].forEach((v) {
      weather.add(Weather.fromJson(v));
    });

    return Daily(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moonPhase: json['moonPhase'],
      temp: Temp.fromJson(
        json['temp'],
      ),
      feelsLike: FeelsLike.fromJson(
        json['feels_like'],
      ),
      humidity: json['humidity'],
      windSpeed: json['windSpeed'],
      windDeg: json['windDeg'],
      windGust: json['windGust'],
      weather: weather,
      clouds: json['clouds'],
      rain: json['rain'],
      snow: json['snow'],
      pop: json['pop'],
    );
  }
}

class Temp {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  const Temp({
    required this.day,
    required this.min,
    required this.max,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      day: json['day'],
      min: json['min'],
      max: json['max'],
      night: json['night'],
      eve: json['eve'],
      morn: json['morn'],
    );
  }
}

class FeelsLike {
  final double day;
  final double night;
  final double eve;
  final double morn;

  const FeelsLike({
    required this.day,
    required this.night,
    required this.eve,
    required this.morn,
  });

  factory FeelsLike.fromJson(Map<String, dynamic> json) {
    return FeelsLike(
      day: json['day'],
      night: json['night'],
      eve: json['eve'],
      morn: json['morn'],
    );
  }
}
