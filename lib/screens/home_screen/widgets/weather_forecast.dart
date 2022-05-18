import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'temperature_graph.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({
    required this.title,
    required this.humidity,
    required this.iconName,
    required this.dayTemperature,
    required this.nightTemperature,
    required this.isDay,
    Key? key,
  }) : super(key: key);

  final String title;
  final int humidity;
  final String iconName;

  final int nightTemperature;
  final int dayTemperature;

  final bool isDay;

  String _formatTemp(int temp) {
    String formattedString = '';
    if (temp > 0) formattedString += '+';
    if (temp < 0) formattedString += '-';
    if (temp == 0) formattedString += ' ';

    if (temp >= -9 && temp <= 9) {
      formattedString += '$temp';
      formattedString += '  ';
    } else {
      formattedString += '$temp';
    }

    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.ptSerif(
                fontWeight: FontWeight.w300,
                textStyle: const TextStyle(
                  color: Color(0xFF8D96B1),
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'icons/drop.png',
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                  ),
                  child: Text(
                    '$humidity%',
                    style: GoogleFonts.ptSerif(
                      fontWeight: FontWeight.w400,
                      textStyle: const TextStyle(
                        color: Color(0xFFAFBBC2),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Image.asset(
              'icons/weather/$iconName.png',
              height: 50,
              width: 50,
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    _formatTemp(nightTemperature),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.ptSerif(
                      fontWeight: FontWeight.w400,
                      textBaseline: TextBaseline.alphabetic,
                      textStyle: TextStyle(
                        textBaseline: TextBaseline.alphabetic,
                        color: !isDay ? Colors.black : const Color(0xFFAFBBC2),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomPaint(
                    painter: TemperatureGraph(
                      dayTemperature: dayTemperature,
                      nightTemperature: nightTemperature,
                    ),
                    size: Size.infinite,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    _formatTemp(dayTemperature),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.ptSerif(
                      fontWeight: FontWeight.w400,
                      textStyle: TextStyle(
                        color: isDay ? Colors.black : const Color(0xFFAFBBC2),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
