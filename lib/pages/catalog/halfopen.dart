import 'package:chessapp/components/lvl.dart';
import 'package:chessapp/components/mybutton.dart';
import 'package:chessapp/components/statistics.dart';
import 'package:flutter/material.dart';

class Halfopen extends StatelessWidget {
  const Halfopen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Полуоткрытые дебюты",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromRGBO(243, 196, 0, 1),
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
                    color: Color.fromRGBO(243, 196, 0, 1),
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
                        'Полуоткрытые дебюты начинаются с хода белых 1. c4, 1. Nf3 или других ходов, не являющихся стандартными открытыми началами. Эти дебюты предлагают разнообразные позиции и возможности для развития игры.',
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
                  const Color.fromRGBO(243, 196, 0, 1),
                  const Color.fromRGBO(255, 243, 219, 1),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      LvlButton(
                        buttonText: 'Скандинавская защита',
                        status: Status.newbie,
                        buttonColor: Color.fromRGBO(69, 201, 142, 1),
                        shadowColor: Color.fromRGBO(69, 201, 142, 0.3),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Защита Оуэна',
                        status: Status.newbie,
                        buttonColor: Color.fromRGBO(69, 201, 142, 1),
                        shadowColor: Color.fromRGBO(69, 201, 142, 0.3),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Французская защита',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Современная защита',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Дебют Нимцовича',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Защита Алехина',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Сицилианская защита',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Гамбит Морра',
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
