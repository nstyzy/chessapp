import 'package:chessapp/components/mybutton.dart';
import 'package:chessapp/pages/info.dart';
import 'package:chessapp/pages/language.dart';
import 'package:chessapp/pages/license.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Убираем стрелку "назад"
        title: const Text(
          'Настройки',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(120, 120, 120, 1)),
        ),
        // Дополнительные параметры для настройки шапки
        centerTitle: true, // Размещаем заголовок по центру
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SettBtn(
                            title: 'Язык',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Language()));
                            }),
                        SettBtn(
                            title: 'Расшифровка обозначений',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Info()));
                            }),
                        const SizedBox(height: 40),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 9),
                          child: Text(
                            "Общие",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(90, 88, 88, 1)),
                          ),
                        ),
                        SettBtn(title: 'Оценить приложение', onTap: () {}),
                        SettBtn(title: 'Отправить отзыв', onTap: () {}),
                        SettBtn(
                            title: 'О программе',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const License()));
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
