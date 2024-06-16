import 'package:chessapp/components/lvl.dart';
import 'package:chessapp/components/mybutton.dart';
import 'package:chessapp/components/statistics.dart';
import 'package:flutter/material.dart';

class Closed extends StatelessWidget {
  const Closed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Закрытые дебюты",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromRGBO(245, 91, 75, 1),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(245, 91, 75, 1),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 6),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Закрытые дебюты отличаются более медленным темпом игры, где игроки стараются укрепить свои позиции и подготовить атаку на противоположной стороне доски. Эти дебюты часто ведут к глубоким стратегическим планам.',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, height: 1.0),
                      ),
                    ),
                  ),
                ),
                circularIndicator(
                  0.01,
                  '0%',
                  const Color.fromRGBO(245, 91, 75, 1),
                  const Color.fromRGBO(254, 223, 220, 1),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      LvlButton(
                        buttonText: 'Лондонская система',
                        status: Status.newbie,
                        buttonColor: Color.fromRGBO(69, 201, 142, 1),
                        shadowColor: Color.fromRGBO(69, 201, 142, 0.3),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Дебют Бёрда',
                        status: Status.newbie,
                        buttonColor: Color.fromRGBO(69, 201, 142, 1),
                        shadowColor: Color.fromRGBO(69, 201, 142, 0.3),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Сарагосское начало',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Дебют Ларсена',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Староиндийская защита',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Каталонское начало',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Защита Бенони',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Дебют Рети',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Дебют Андерсена',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Будапештский гамбит',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Новоиндийская защита',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
