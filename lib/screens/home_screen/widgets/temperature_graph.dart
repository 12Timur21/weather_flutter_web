import 'package:flutter/material.dart';

class TemperatureGraph extends CustomPainter {
  static double maxTemperature = 60;

  final int dayTemperature;
  final int nightTemperature;

  TemperatureGraph({
    required this.dayTemperature,
    required this.nightTemperature,
  });

  void drawDashLine(
    Canvas canvas,
    Size size,
    double dashInterval,
  ) {
    Paint paint = Paint()
      ..color = const Color(0xFFDFEDFB)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    double space = 0;
    while (space <= size.width) {
      canvas.drawLine(
        Offset(space + 5, size.height / 2),
        Offset(
          space + 10,
          size.height / 2,
        ),
        paint,
      );

      space += dashInterval;

      if (space + 5 >= size.width) break;
    }
  }

  void drawVerticalLine(
    Canvas canvas,
    Size size,
    double dashInterval,
  ) {
    Paint paint = Paint()
      ..color = const Color(0xFFDFEDFB)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    double space = 0;

    while (space <= size.height) {
      canvas.drawLine(
        Offset(size.width / 2, space + 5),
        Offset(
          size.width / 2,
          space + 10,
        ),
        paint,
      );

      space += dashInterval;
    }
  }

  void drawNightTemperature(
    Canvas canvas,
    Size size,
    int temperature,
  ) {
    final double offsetX = size.width / maxTemperature * temperature.abs() / 2;

    Paint paint = Paint()
      ..color = temperature < 0 ? Colors.blue : const Color(0xFFD1E4F8)
      ..strokeWidth = 5;

    canvas.drawLine(
      Offset(size.width / 2, size.height / 2),
      Offset(
        size.width / 2 - offsetX,
        size.height / 2,
      ),
      paint,
    );
  }

  void drawDayTemperature(
    Canvas canvas,
    Size size,
    int temperature,
  ) {
    final double offsetX = size.width / maxTemperature * temperature.abs() / 2;

    Paint paint = Paint()
      ..color =
          temperature < 0 ? const Color(0xFFFFE0B2) : const Color(0xFFFA4907)
      ..strokeWidth = 5;

    canvas.drawLine(
      Offset(size.width / 2, size.height / 2),
      Offset(
        size.width / 2 + offsetX,
        size.height / 2,
      ),
      paint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawDashLine(
      canvas,
      size,
      15,
    );

    drawNightTemperature(
      canvas,
      size,
      nightTemperature,
    );

    drawDayTemperature(
      canvas,
      size,
      dayTemperature,
    );

    drawVerticalLine(
      canvas,
      size,
      11,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
