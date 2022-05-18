import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocs/weather/weather_bloc.dart';
import 'package:flutter_application_1/models/weather_model.dart';
import 'package:flutter_application_1/resources/app_colors.dart';
import 'package:flutter_application_1/screens/home_screen/widgets/humidity_graph.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  Map<String, int> getHumidity(List<Hourly> hourly) {
    Map<String, int> humidityMap = {};

    for (Hourly hour in hourly) {
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        hour.dt * 1000,
      );

      if (dateTime.hour % 2 == 0) {
        String designation =
            dateTime.hour >= 0 && dateTime.hour <= 12 ? 'A.M' : 'P.M';

        String key = '${dateTime.hour} $designation';
        humidityMap[key] = hour.humidity;
      }
    }

    return humidityMap;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        String iconName = state.weatherModel?.current.weather[0].icon ?? '01d';

        Image icon = Image.asset(
          'icons/weather/$iconName.png',
          height: 50,
          width: 50,
          alignment: Alignment.center,
        );

        int temp = state.weatherModel?.current.temp.toInt() ?? 0;
        String placeName = state.placeCardModel?.placeName ?? 'NoName';
        int feelsLike = state.weatherModel?.current.feelsLike.toInt() ?? 0;
        String currentDate = 'Data not found';
        if (state.weatherModel?.current.dt != null) {
          final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
            state.weatherModel!.current.dt * 1000,
          );

          currentDate = DateFormat.yMMMMEEEEd().format(dateTime);
        }
        String sunset = 'NoData';
        if (state.weatherModel?.current.sunset != null) {
          final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
            state.weatherModel!.current.sunset * 1000,
          );

          sunset = DateFormat.Hm().format(dateTime);
        }

        Map<String, int> humidityMap = {};
        if (state.weatherModel?.hourly != null) {
          humidityMap = getHumidity(state.weatherModel!.hourly);
        }

        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.darkPurple,
            child: state.weatherModel == null
                ? const Center(
                    child: Text(
                      'Select place',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      ..._clouds,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              icon,
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Today',
                                    style: TextStyle(
                                      fontSize: 40,
                                    ),
                                  ),
                                  Text(
                                    currentDate,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFFA0A0B2),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '$temp°С',
                            style: const TextStyle(
                              fontSize: 180,
                            ),
                          ),
                          Text(
                            placeName,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Color(0xFFA0A0B2),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'FeelsLike $feelsLike  - Sunset $sunset', //10:15
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFFA0A0B2),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.040,
                          ),
                          LayoutBuilder(
                            builder: (builder, constraints) {
                              double horizontalPadding = 0;

                              if (constraints.maxWidth >= 900) {
                                horizontalPadding = 120;
                              } else if (constraints.maxWidth >= 600) {
                                horizontalPadding = 60;
                              } else {
                                horizontalPadding = 20;
                              }

                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding,
                                  vertical: 40,
                                ),
                                child: SizedBox(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // const Text(
                                      //   'Chance of rain',
                                      //   style: TextStyle(
                                      //     color: Colors.white,
                                      //     fontSize: 24,
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 20,
                                      // ),
                                      Expanded(
                                        child: CustomPaint(
                                          painter: HumidityGraph(humidityMap),
                                          size: Size.infinite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }
}

List<Positioned> _clouds = const [
  Positioned(
    top: 300,

    left: -200,
    child: Icon(
      Icons.cloud_rounded,
      size: 500,
      color: AppColors.clouds,
    ), //Icon
  ), //
  Positioned(
    top: 100,

    right: -200,
    child: Icon(
      Icons.cloud_rounded,
      size: 400,
      color: AppColors.clouds,
    ), //Icon
  ), //
  Positioned(
    top: 800,
    right: -150,
    child: Icon(
      Icons.cloud_rounded,
      size: 400,
      color: AppColors.clouds,
    ), //Icon
  ),
];
