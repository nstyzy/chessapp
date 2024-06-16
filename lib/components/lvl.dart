import 'package:flutter/material.dart';

enum Status { newbie, player, master, grandmaster }

class StatusContainer extends StatelessWidget {
  final Status status;

  const StatusContainer({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color containerColor;
    Color textColor;
    String text;

    switch (status) {
      case Status.newbie:
        containerColor = const Color.fromRGBO(200, 236, 220, 1);
        textColor = const Color.fromRGBO(80, 117, 101, 1);
        text = 'Новичок';
        break;
      case Status.player:
        containerColor = const Color.fromRGBO(255, 243, 219, 1);
        textColor = const Color.fromRGBO(226, 186, 20, 1);
        text = 'Игрок';
        break;
      case Status.master:
        containerColor = const Color.fromRGBO(254, 223, 220, 1);
        textColor = const Color.fromRGBO(245, 91, 75, 1);
        text = 'Мастер';
        break;
      case Status.grandmaster:
        containerColor = const Color.fromRGBO(219, 198, 249, 1);
        textColor = const Color.fromRGBO(123, 68, 227, 1);
        text = 'Гроссмейстер';
        break;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 60,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: containerColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                  fontFamily: 'Jost'),
            ),
          ),
        ),
      ),
    );
  }
}
