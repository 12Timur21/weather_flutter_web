import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocs/weather/weather_bloc.dart';
import 'package:flutter_application_1/models/weather_model.dart';
import 'package:flutter_application_1/screens/home_screen/widgets/weather_forecast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

class WeatherGrid extends StatelessWidget {
  const WeatherGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.weatherModel?.daily.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            Daily? daily = state.weatherModel?.daily[index];

            if (daily == null) return const SizedBox();

            final DateTime dateTime =
                DateTime.fromMillisecondsSinceEpoch(daily.dt * 1000);

            String dayOfWeek = DateFormat('EEEE').format(dateTime);

            return WeatherForecast(
              title: dayOfWeek,
              iconName: daily.weather?[0].icon ?? '03n',
              humidity: daily.humidity,
              dayTemperature: daily.temp?.day.toInt() ?? 0,
              nightTemperature: daily.temp?.night.toInt() ?? 0,
              isDay: true,
            );
          },
        );
      },
    );
  }
}
