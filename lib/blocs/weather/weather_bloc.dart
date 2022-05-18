import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/models/place_card_model.dart';
import 'package:flutter_application_1/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState()) {
    on<ChagneWeatherModel>((event, emit) {
      emit(
        WeatherState(
          weatherModel: event.weatherModel,
          placeCardModel: event.placeCardModel,
        ),
      );
    });
  }
}
