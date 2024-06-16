import 'package:chessapp/pages/home.dart';
import 'package:chessapp/pages/settings.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndexx = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndexx = index;
    });
  }

  final List _pages = [
    const Home(),
    Profile(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndexx],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red, // Устанавливаем красный цвет для выбранного элемента
        elevation: 0,
        currentIndex: _selectedIndexx, // Указываем текущий выбранный индекс
        onTap: _navigateBottomBar, // Обновляем выбранный индекс при нажатии
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
}
