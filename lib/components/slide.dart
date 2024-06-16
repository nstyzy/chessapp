
import 'package:flutter/material.dart';

Widget slider(BuildContext context, String imagePath, String title, String description) {
  return Container(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width,
          ),
          Text(
            title,
            softWrap: true,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              height: 1.2,
              color: Color.fromRGBO(69, 90, 100, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            softWrap: true,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              height: 1.0,
              color: Color.fromRGBO(69, 90, 100, 1),
            ),
          ),
        ],
      ),
    ),
  );
}