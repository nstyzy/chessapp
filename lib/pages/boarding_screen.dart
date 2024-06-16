import 'package:chessapp/components/slide.dart';
import 'package:chessapp/pages/auth/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            slider(
                context,
                'lib/images/slideone.png',
                'Добро пожаловать в мир шахматных дебютов!',
                'Здесь вы найдете все необходимое для расширения своих знаний и улучшения своей игры. Готовы погрузиться в мир стратегии и тактики?'),
            slider(
                context,
                'lib/images/slidetwo.png',
                'Исследуйте различные дебюты, узнавайте их особенности и идеи.',
                'Вас ждут подробные описания каждого дебюта, чтобы помочь лучше понять игровую ситуацию и принимать обоснованные решения.'),
            slider(
                context,
                'lib/images/slidethree.png',
                'Отслеживайте свою статистику и узнайте, над чем стоит поработать.',
                'Используйте тренажеры для закрепления знаний и улучшения своих навыков. Готовы стать сильным игроком и покорить новые высоты в шахматах?'),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _controller.jumpToPage(2);
                },
                child: const Icon(Icons.redo_rounded,
                    color: Color.fromRGBO(184, 50, 36, 0.5)),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const ScrollingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 20.0,
                    activeDotColor: Color.fromRGBO(184, 50, 36, 1),
                    dotColor: Color.fromRGBO(184, 50, 36, 0.5)),
              ),
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return (const AuthPage());
                          }),
                        );
                      },
                      child: const Icon(Icons.done_rounded,
                          color: Color.fromRGBO(184, 50, 36, 1)),
                    )
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Icon(Icons.arrow_forward_rounded,
                          color: Color.fromRGBO(184, 50, 36, 0.5)),
                    ),
            ],
          ),
        ),
      ]),
    );
  }
}
