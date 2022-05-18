part of 'weather_bloc.dart';

class WeatherState {
  WeatherModel? weatherModel;
  PlaceCardModel? placeCardModel;

  WeatherState({
    this.weatherModel,
    this.placeCardModel,
  });

  WeatherState copyWith({
    WeatherModel? weatherModel,
    PlaceCardModel? placeCardModel,
  }) {
    return WeatherState(
      weatherModel: weatherModel ?? this.weatherModel,
      placeCardModel: placeCardModel ?? this.placeCardModel,
    );
  }
}
