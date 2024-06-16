import 'package:chessapp/components/mybutton.dart';
import 'package:chessapp/pages/catalog/closed.dart';
import 'package:chessapp/pages/catalog/halfopen.dart';
import 'package:chessapp/pages/catalog/open.dart';
import 'package:chessapp/pages/opening.dart';
import 'package:chessapp/pages/rules.dart';
import 'package:chessapp/pages/soon.dart';
import 'package:chessapp/pages/statistic.dart';
import 'package:chessapp/pages/traines.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'catalog/gambits.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> allDebuts = [];
  List<Map<String, dynamic>> filteredDebuts = [];
  bool isSearchActive = false;

  @override
  void initState() {
    super.initState();
    allDebuts = [
      {'name': 'Английское начало', 'action': navigateToOpening},
      {'name': 'Центральный дебют', 'action': navigateToComming},
      {'name': 'Дебют Понциани', 'action': navigateToComming},
      {'name': 'Венская партия', 'action': navigateToComming},
      {'name': 'Защита Филидора', 'action': navigateToComming},
      {'name': 'Защита двух коней', 'action': navigateToComming},
      {'name': 'Дебют трёх коней', 'action': navigateToComming},
      {'name': 'Русская партия', 'action': navigateToComming},
      {'name': 'Берлинская защита', 'action': navigateToComming},
      {'name': 'Венгерская партия', 'action': navigateToComming},
      {'name': 'Дебют четырех коней', 'action': navigateToComming},
      {'name': 'Скандинавская защита', 'action': navigateToComming},
      {'name': 'Защита Оуэна', 'action': navigateToComming},
      {'name': 'Французская защита', 'action': navigateToComming},
      {'name': 'Современная защита', 'action': navigateToComming},
      {'name': 'Дебют Нимцовича', 'action': navigateToComming},
      {'name': 'Защита Алехина', 'action': navigateToComming},
      {'name': 'Сицилианская защита', 'action': navigateToComming},
      {'name': 'Гамбит Морра', 'action': navigateToComming},
      {'name': 'Французская защита', 'action': navigateToComming},
      {'name': 'Французская защита', 'action': navigateToComming},
      {'name': 'Французская защита', 'action': navigateToComming},
    ];
    searchController.addListener(() {
      filterDebuts();
    });
  }

  void navigateToComming() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Comming()));
  }

  void navigateToOpening() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Debut()));
  }

  void filterDebuts() {
    List<Map<String, dynamic>> results;
    if (searchController.text.isEmpty) {
      results = []; // Не отображаем дебюты, если нет текста
    } else {
      results = allDebuts
          .where((debuts) => debuts['name']
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredDebuts = results;
    });
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Скрываем клавиатуру и закрываем список поиска при нажатии на экран
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          isSearchActive = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "ChessMastery",
            style: TextStyle(color: Colors.white, fontFamily: 'PottaOne'),
          ),
          backgroundColor: const Color.fromRGBO(245, 91, 75, 1),
          
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(245, 91, 75, 1),
                  ),
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              controller: searchController,
                              onTap: () {},
                              onChanged: (value) {
                                // Активируем поиск только когда есть введенный текст
                                setState(() {
                                  isSearchActive = value.isNotEmpty;
                                });
                                filterDebuts(); // Вызываем фильтрацию дебютов при каждом изменении текста
                              },
                              style: const TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.4)),
                              decoration: InputDecoration(
                                iconColor: const Color.fromRGBO(0, 0, 0, 0.4),
                                hintText: 'Например, итальянская игра',
                                hintStyle: const TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.4)),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Color.fromRGBO(0, 0, 0, 0.4),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                              ),
                            ),
                          ),
                        ),
                        if (isSearchActive)
                          ListView.builder(
                            shrinkWrap: true, 
                            physics:
                                const NeverScrollableScrollPhysics(), 
                            itemCount: filteredDebuts.length,
                            itemBuilder: (context, index) {
                              return Container(
                                color: Colors.white,
                                child: ListTile(
                                  title: Text(filteredDebuts[index]['name']),
                                  onTap: filteredDebuts[index]['action'],
                                ),
                              );
                            },
                          ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 25, left: 50, right: 50),
                  child: Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 900),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customElevatedButton(
                                'lib/images/chessg.png', 'Играть', () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const GameBoard()));
                            }),
                            customElevatedButton(
                                'lib/images/chessplayer.png', 'Тренажеры', () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Trains()));
                            }),
                            customElevatedButton(
                                'lib/images/statistics.png', 'Статистика', () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Statistic()));
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25, left: 25, top: 20),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Категории',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(101, 101, 101, 1)),
                        ),
                        const SizedBox(height: 20),
                        customButton(
                          'Открытые дебюты',
                          '14 уроков',
                          'lib/images/book.png',
                          const Color.fromRGBO(69, 201, 142, 0.3),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Open(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        customButton(
                          'Полуоткрытые дебюты',
                          '8 уроков',
                          'lib/images/book.png',
                          const Color.fromRGBO(250, 220, 96, 0.4),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Halfopen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        customButton(
                          'Закрытые дебюты',
                          '11 уроков',
                          'lib/images/book.png',
                          const Color.fromRGBO(245, 91, 75, 0.3),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Closed(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        customButton(
                          'Шахматные гамбиты',
                          '20 уроков',
                          'lib/images/book.png',
                          const Color.fromRGBO(147, 76, 245, 0.3),
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Gambits(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
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
