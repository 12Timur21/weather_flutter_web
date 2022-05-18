import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/app_colors.dart';

class HumidityGraph extends CustomPainter {
  final Map<String, int> humidityMap;
  HumidityGraph(this.humidityMap);

  void _drawVerticalLine(
    Canvas canvas,
    Size size, {
    required double paddingX,
    required bool isActive,
    required int humidity,
    required String time,
  }) {
    Paint dashPaint = Paint()
      ..color = AppColors.noActiveIndicator
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    double space = 0;

    while (space <= size.height) {
      canvas.drawLine(
        Offset(paddingX, space + 5 - 60),
        Offset(
          paddingX,
          space + 20 - 60,
        ),
        dashPaint,
      );

      space += 30;
    }

    Paint thickLine = Paint()
      ..color =
          isActive ? AppColors.activeIndicator : AppColors.noActiveIndicator
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(paddingX, size.height - 50),
      Offset(
        paddingX,
        size.height * double.parse('0.$humidity') - 20,
      ),
      thickLine,
    );

    TextSpan textSpan = TextSpan(
      text: time,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    textPainter.paint(
      canvas,
      Offset(
        paddingX - 15,
        size.height - 30,
      ),
    );
  }

  void _drawIndicators(Canvas canvas, Size size) {
    double offsetY = (size.height - 70) / 10;

    for (int i = 0; i < 11; i++) {
      int value = 100;

      if (i == 0) value = 100;

      if (i > 0) value = (100 - (i * 10));

      if (i % 2 == 0) {
        TextSpan textSpan = TextSpan(
          text: value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        textPainter.paint(
          canvas,
          Offset(
            0,
            i == 0 ? 0 : offsetY * i,
          ),
        );
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    _drawIndicators(
      canvas,
      size,
    );

    final double lineSpace = size.width / 6 - 10;
    int i = 0;
    humidityMap.forEach((key, value) {
      if (i < 6) {
        _drawVerticalLine(
          canvas,
          size,
          paddingX: lineSpace * (i + 1),
          time: key,
          isActive: i == 4 ? true : false,
          humidity: value,
        );
        i++;
      }
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
