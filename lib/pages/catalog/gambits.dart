import 'package:chessapp/components/lvl.dart';
import 'package:chessapp/components/mybutton.dart';
import 'package:chessapp/components/statistics.dart';
import 'package:flutter/material.dart';

class Gambits extends StatelessWidget {
  const Gambits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Шахматные гамбиты",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromRGBO(161, 123, 242, 1),
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
                    color: Color.fromRGBO(161, 123, 242, 1),
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
                        'Гамбит – разновидность дебюта, или дебютный вариант, в котором один из игроков готов настии материальные жертвы ради достижении своих целей. ',
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
                  const Color.fromRGBO(161, 123, 242, 1),
                  const Color.fromRGBO(219, 198, 249, 1),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      LvlButton(
                        buttonText: 'Волжский гамбит',
                        status: Status.newbie,
                        buttonColor: Color.fromRGBO(69, 201, 142, 1),
                        shadowColor: Color.fromRGBO(69, 201, 142, 0.3),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Гамбит Блэкмара-Димера',
                        status: Status.newbie,
                        buttonColor: Color.fromRGBO(69, 201, 142, 1),
                        shadowColor: Color.fromRGBO(69, 201, 142, 0.3),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Шотландский гамбит',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Гамбит Эванса',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Голландский гамбит',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Северный гамбит',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Ферзевый гамбит',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Королевский гамбит',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Латышский гамбит',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 20),
                      LvlButton(
                        buttonText: 'Гамбит Хэллоуин',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Контргамбит Альбина защита',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Контргамбит Винавера',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Львовский гамбит',
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
