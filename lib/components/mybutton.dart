// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:chessapp/components/lvl.dart';
import 'package:chessapp/pages/soon.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Color.fromRGBO(245, 91, 75, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

Widget customButton(String title, String subtitle, String imagePath,
    Color shadowColor, VoidCallback onPressed) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: shadowColor,
          offset: Offset(0, 4),
          blurRadius: 2,
        ),
      ],
    ),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        elevation: MaterialStateProperty.all(0),
        foregroundColor:
            MaterialStateProperty.all(const Color.fromRGBO(101, 101, 101, 1)),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image(image: AssetImage(imagePath), width: 50.0),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w300),
                    )
                  ],
                )
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 20),
          ],
        ),
      ),
    ),
  );
}

Widget customElevatedButton(
    String imagePath, String buttonText, VoidCallback? onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      elevation: MaterialStateProperty.all(0),
      foregroundColor:
          MaterialStateProperty.all(const Color.fromRGBO(101, 101, 101, 1)),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Colors.transparent),
        ),
      ),
    ),
    child: Column(
      children: <Widget>[
        Image(image: AssetImage(imagePath), width: 73.0),
        Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

class LvlButton extends StatelessWidget {
  final String buttonText;
  final Status status;
  final Color buttonColor;
  final Color shadowColor;
  final double percent;

  const LvlButton({
    super.key,
    required this.buttonText,
    required this.status,
    required this.buttonColor,
    required this.shadowColor,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(165, 137, 137, 1).withOpacity(0.4),
            offset: const Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
          foregroundColor:
              MaterialStateProperty.all(const Color.fromRGBO(101, 101, 101, 1)),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: () {Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Comming()));},
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      buttonText,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    StatusContainer(status: status),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 1.0),
                child: LinearPercentIndicator(
                  lineHeight: 4,
                  percent: percent,
                  progressColor: buttonColor,
                  backgroundColor: shadowColor,
                  barRadius: const Radius.circular(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SettBtn extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettBtn({super.key, 
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromRGBO(159, 159, 159, 1),
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: Color(0xFF57636C), fontSize: 16),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF57636C),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}