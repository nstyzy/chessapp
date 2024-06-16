import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget circularIndicator(double percent, String text, Color progressColor, Color backgroundColor) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: CircularPercentIndicator(
      animation: true,
      animationDuration: 1000,
      radius: 50,
      lineWidth: 10,
      percent: percent,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: progressColor,
        ),
      ),
    ),
  );
}