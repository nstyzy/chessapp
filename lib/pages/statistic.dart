import 'package:chessapp/components/lvl.dart';
import 'package:chessapp/components/statistics.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Statistic extends StatefulWidget {
  const Statistic({super.key});

  @override
  State<Statistic> createState() => _StatisticState();
}

class DebutsInfo extends StatelessWidget {
  final String title;
  final double percent;
  final String progressText;
  final Color progressColor;
  final Color backgroundColor;

  const DebutsInfo({
    super.key,
    required this.title,
    required this.percent,
    required this.progressText,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 170),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            circularIndicator(
              percent,
              progressText,
              progressColor,
              backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({
    super.key,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}

class PercentIndicator extends StatelessWidget {
  final double percent;
  final Color progressColor;
  final String percentText;

  const PercentIndicator({
    super.key,
    required this.percent,
    required this.progressColor,
    required this.percentText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: LinearPercentIndicator(
            width: 180,
            lineHeight: 30,
            percent: percent,
            progressColor: progressColor,
            backgroundColor: const Color.fromRGBO(236, 236, 236, 1),
            barRadius: const Radius.circular(8),
          ),
        ),
        Text(
          percentText,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 10,
            color: progressColor,
          ),
        ),
      ],
    );
  }
}

class _StatisticState extends State<Statistic> {
  late OverlayEntry _overlayEntry;

  void _showOverlay(BuildContext context) {
    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context).insert(_overlayEntry);
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (BuildContext context) => GestureDetector(
        onTap: () {
          _overlayEntry.remove();
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                width: 230,
                height: 160,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(20)), // Закругление углов
                ),
                child: const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('от 0 до 9',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Jost',
                                  color: Color.fromRGBO(101, 101, 101, 1),
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none)),
                          StatusContainer(
                            status: Status.newbie,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('от 10 до 24',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Jost',
                                  color: Color.fromRGBO(101, 101, 101, 1),
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none)),
                          StatusContainer(
                            status: Status.player,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('от 25 до 45',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Jost',
                                  color: Color.fromRGBO(101, 101, 101, 1),
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none)),
                          StatusContainer(
                            status: Status.master,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('max',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Jost',
                                  color: Color.fromRGBO(101, 101, 101, 1),
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none)),
                          StatusContainer(
                            status: Status.grandmaster,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: -8,
                top: -8,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onPressed: () {
                    _overlayEntry.remove();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double percent = 0.0; // Значение по умолчанию

  @override
  void initState() {
    super.initState();
    _loadPercent();
  }

  void _loadPercent() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      percent =
          prefs.getDouble('percent') ?? 0.0; // Загрузка сохраненного значения
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
                color: Color.fromRGBO(101, 101, 101, 1), fontFamily: 'Jost'),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Статистика",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Jost',
                color: Color.fromRGBO(101, 101, 101, 1),
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Игровой ранг',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showOverlay(context);
                                  },
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(217, 217, 217, 1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '?',
                                        style: TextStyle(fontSize: 10),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const StatusContainer(
                              status: Status.newbie,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.85,
                            lineHeight: 6,
                            percent: percent / 10,
                            progressColor:
                                const Color.fromRGBO(69, 201, 142, 1),
                            backgroundColor:
                                const Color.fromRGBO(69, 201, 142, 0.3)
                                    .withOpacity(0.3),
                            barRadius: const Radius.circular(50),
                            animation: true,
                            animationDuration: 1000,
                          ),
                          Text(
                            '${(percent * 10).toStringAsFixed(0)}%', // Обновление текста процента
                            style: const TextStyle(
                                color: Color.fromRGBO(69, 201, 142, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Всего уроков пройдено',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RotatedBox(
                                    quarterTurns: 3,
                                    child: LinearPercentIndicator(
                                      width: 180,
                                      lineHeight: 30,
                                      percent: percent / 14,
                                      progressColor:
                                          const Color.fromRGBO(69, 201, 142, 1),
                                      backgroundColor: const Color.fromRGBO(
                                          236, 236, 236, 1),
                                      barRadius: const Radius.circular(8),
                                    ),
                                  ),
                                  Text(
                                    '${(percent * 7).toStringAsFixed(0)}%',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Color.fromRGBO(69, 201, 142, 1),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 20),
                              const PercentIndicator(
                                percent: 0,
                                progressColor: Color.fromRGBO(250, 220, 96, 1),
                                percentText: '0%',
                              ),
                              const SizedBox(width: 20),
                              const PercentIndicator(
                                percent: 0,
                                progressColor: Color.fromRGBO(245, 91, 75, 1),
                                percentText: '0%',
                              ),
                              const SizedBox(width: 20),
                              const PercentIndicator(
                                percent: 0,
                                progressColor: Color.fromRGBO(161, 123, 242, 1),
                                percentText: '0%',
                              ),
                            ],
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LegendItem(
                                color: Color.fromRGBO(69, 201, 142, 1),
                                text: 'Открытые дебюты',
                              ),
                              LegendItem(
                                color: Color.fromRGBO(250, 220, 96, 1),
                                text: 'Полуоткрытые дебюты',
                              ),
                              LegendItem(
                                color: Color.fromRGBO(245, 91, 75, 1),
                                text: 'Закрытые дебюты',
                              ),
                              LegendItem(
                                color: Color.fromRGBO(161, 123, 242, 1),
                                text: 'Шахматные гамбиты',
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text('Всего пройдено:'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LinearPercentIndicator(
                                width: MediaQuery.of(context).size.width * 0.85,
                                lineHeight: 6,
                                percent: percent / 46,
                                progressColor:
                                    const Color.fromRGBO(69, 201, 142, 1),
                                backgroundColor:
                                    const Color.fromRGBO(69, 201, 142, 0.3)
                                        .withOpacity(0.3),
                                barRadius: const Radius.circular(50),
                                animation: true,
                                animationDuration: 1000,
                              ),
                              Text(
                                '${(percent * 2).toStringAsFixed(0)}%', // Обновление текста процента
                                style: const TextStyle(
                                    color: Color.fromRGBO(69, 201, 142, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(minWidth: 170),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Открытые дебюты',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: CircularPercentIndicator(
                                          animation: true,
                                          animationDuration: 1000,
                                          radius: 50,
                                          lineWidth: 10,
                                          percent: percent / 14,
                                          progressColor: const Color.fromRGBO(
                                              69, 201, 142, 1),
                                          backgroundColor: const Color.fromRGBO(
                                              200, 236, 220, 1),
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          center: Text(
                                            '${percent.toInt()} / 14',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromRGBO(
                                                  69, 201, 142, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const DebutsInfo(
                                title: 'Полуоткрытые дебюты',
                                percent: 0.001,
                                progressText: '0 / 8',
                                progressColor: Color.fromRGBO(243, 196, 0, 1),
                                backgroundColor:
                                    Color.fromRGBO(255, 243, 219, 1),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DebutsInfo(
                                title: 'Закрытые дебюты',
                                percent: 0.001,
                                progressText: '0 / 11',
                                progressColor: Color.fromRGBO(245, 91, 75, 1),
                                backgroundColor:
                                    Color.fromRGBO(254, 223, 220, 1),
                              ),
                              DebutsInfo(
                                title: 'Шахматные гамбиты',
                                percent: 0.001,
                                progressText: '0 / 13',
                                progressColor: Color.fromRGBO(161, 123, 242, 1),
                                backgroundColor:
                                    Color.fromRGBO(219, 198, 249, 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
