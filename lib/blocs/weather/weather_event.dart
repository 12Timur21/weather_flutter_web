part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class ChagneWeatherModel extends WeatherEvent {
  final WeatherModel weatherModel;
  final PlaceCardModel placeCardModel;

  const ChagneWeatherModel({
    required this.weatherModel,
    required this.placeCardModel,
  });
}
