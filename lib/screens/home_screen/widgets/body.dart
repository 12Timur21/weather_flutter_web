import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocs/place_cards/place_cards_bloc.dart';
import 'package:flutter_application_1/blocs/weather/weather_bloc.dart';
import 'package:flutter_application_1/models/place_card_model.dart';
import 'package:flutter_application_1/models/weather_model.dart';
import 'package:flutter_application_1/resources/app_colors.dart';
import 'package:flutter_application_1/screens/home_screen/widgets/custom_search_bar.dart';
import 'package:flutter_application_1/screens/home_screen/widgets/place_card.dart';
import 'package:flutter_application_1/services/weather_api.dart';
import 'package:flutter_application_1/utils/toast_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'weather_grid.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onAutocompleteSearchComplete(
    PlaceCardModel placeCardModel,
    BuildContext context,
  ) {
    context.read<PlaceCardsBloc>().add(
          AddPlaceCard(placeCardModel),
        );
  }

  Future<void> _onCheckWeather(PlaceCardModel placeModel) async {
    try {
      WeatherModel weatherModel = await WeatherApi.instance.getWeather(
        lat: placeModel.location!.lat,
        lon: placeModel.location!.lng,
      );

      // final String response = await rootBundle.loadString(
      //   'assets/json/weather.json',
      // );
      // final data = await json.decode(response);
      // WeatherModel weatherModel = WeatherModel.fromJson(data);

      context.read<WeatherBloc>().add(
            ChagneWeatherModel(
              weatherModel: weatherModel,
              placeCardModel: placeModel,
            ),
          );
    } catch (e) {
      ToastBox.instance.showErrorToast(
        context: context,
        text: 'Не удалось получить погоду в данном регионе',
      );
      log(e.toString());
    }
  }

  void testFunc() async {
    // final String response = await rootBundle.loadString(
    //   'assets/json/weather.json',
    // );
    // final data = await json.decode(response);
    // WeatherModel wm = WeatherModel.fromJson(data);
    // context.read<WeatherBloc>().add(
    //       ChagneWeatherModel(
    //         placeCardModel: const PlaceCardModel(
    //           placeName: 'Kiev',
    //         ),
    //         weatherModel: wm,
    //       ),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.lightSand,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(
                onSubmit: (PlaceCardModel placeCardModel) {
                  _onAutocompleteSearchComplete(placeCardModel, context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: GestureDetector(
                  onTap: testFunc,
                  child: RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Weather',
                          style: TextStyle(
                            color: AppColors.darkPurple,
                            fontSize: 30,
                          ),
                        ),
                        TextSpan(
                          text: '   ',
                        ),
                        TextSpan(
                          text: 'App',
                          style: TextStyle(
                            color: AppColors.darkPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<PlaceCardsBloc, PlaceCardsState>(
                builder: (context, state) {
                  if (state.placeCardModel.isEmpty) {
                    return const SizedBox();
                  }
                  return SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.placeCardModel.length,
                      itemBuilder: (context, index) {
                        double paddingLeft = 20;

                        if (index == 0) paddingLeft = 0;

                        return Padding(
                          padding: EdgeInsets.only(
                            left: paddingLeft,
                          ),
                          child: PlaceCard(
                            placeCardModel: state.placeCardModel[index],
                            onTap: (PlaceCardModel placeModel) {
                              _onCheckWeather(placeModel);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const Expanded(
                child: WeatherGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
