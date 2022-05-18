import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocs/place_cards/place_cards_bloc.dart';
import 'package:flutter_application_1/blocs/weather/weather_bloc.dart';
import 'package:flutter_application_1/screens/home_screen/widgets/body.dart';
import 'package:flutter_application_1/screens/home_screen/widgets/sidebar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlaceCardsBloc(),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: LayoutBuilder(
        builder: (builder, constraints) {
          if (constraints.maxWidth >= 1000) {
            return Row(
              children: [
                const Expanded(
                  child: Body(),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: const Sidebar(),
                ),
              ],
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Body(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Sidebar(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
