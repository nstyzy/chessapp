import 'package:chessapp/components/lvl.dart';
import 'package:chessapp/components/mybutton.dart';
import 'package:chessapp/components/statistics.dart';
import 'package:chessapp/pages/homepage.dart';
import 'package:chessapp/pages/opening.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Open extends StatefulWidget {
  const Open({super.key});

  @override
  State<Open> createState() => _OpenState();
}

class _OpenState extends State<Open> {
  double percent = 0.1; // Значение по умолчанию

  double circularPercent = 0.0; // Инициализируем с начальным значением

  double calculateCircularPercent(double linearPercent) {
    // Преобразуем линейный процент в круглый индикатор
    // Например, если линейный индикатор заполнен на 50%, то круглый должен быть заполнен на 3.5%
    return linearPercent * 0.07;
  }

  @override
  void initState() {
    super.initState();
    _loadPercent();
    circularPercent = calculateCircularPercent(percent);
  }

  void _loadPercent() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      percent = prefs.getDouble('percent') ?? 0.1;
      circularPercent =
          calculateCircularPercent(percent); // Обновляем круглый индикатор
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Открытые дебюты",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromRGBO(69, 201, 142, 1),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
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
                    color: Color.fromRGBO(69, 201, 142, 1),
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
                        'В этой категории собраны дебюты, где белые и черные стремятся быстро развивать свои фигуры и управлять центром доски. Открытые дебюты характеризуются активной игрой и частыми обменами фигур.',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, height: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      circularIndicator(
                        circularPercent,
                        '${(circularPercent * 100).toStringAsFixed(0)}%',
                        const Color.fromRGBO(69, 201, 142, 1),
                        const Color.fromRGBO(200, 236, 220, 1),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(165, 137, 137, 1)
                                  .withOpacity(0.3),
                              offset: const Offset(0, 2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                            foregroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(101, 101, 101, 1)),
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Debut()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 5),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Английское начало',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      StatusContainer(status: Status.newbie),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 1.0),
                                  child: LinearPercentIndicator(
                                    lineHeight: 4,
                                    percent: percent,
                                    progressColor:
                                        const Color.fromRGBO(69, 201, 142, 1),
                                    backgroundColor:
                                        const Color.fromRGBO(69, 201, 142, 0.3)
                                            .withOpacity(0.3),
                                    barRadius: const Radius.circular(50),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      LvlButton(
                        buttonText: 'Центральный дебют',
                        status: Status.newbie,
                        buttonColor: Color.fromRGBO(69, 201, 142, 1),
                        shadowColor: Color.fromRGBO(69, 201, 142, 0.3),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Шотландская партия',
                        status: Status.newbie,
                        buttonColor: Color.fromRGBO(69, 201, 142, 1),
                        shadowColor: Color.fromRGBO(69, 201, 142, 0.3),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Дебют Понциани',
                        status: Status.newbie,
                        buttonColor: Color.fromRGBO(69, 201, 142, 1),
                        shadowColor: Color.fromRGBO(69, 201, 142, 0.3),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Венская партия',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Итальянская партия',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Защита Филидора',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Защита двух коней',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Дебют трёх коней',
                        status: Status.player,
                        buttonColor: Color.fromRGBO(250, 220, 96, 1),
                        shadowColor: Color.fromRGBO(252, 206, 40, 0.275),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Испанская партия',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Русская партия',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Дебют четырех коней',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Берлинская защита',
                        status: Status.master,
                        buttonColor: Color.fromRGBO(245, 91, 75, 0.6),
                        shadowColor: Color.fromRGBO(245, 91, 75, 0.2),
                        percent: 0.01,
                      ),
                      SizedBox(height: 15),
                      LvlButton(
                        buttonText: 'Венгерская партия',
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
