import 'package:chessapp/pages/auth/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Переход на страницу Auth через 2 секунды
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ChessMastery',
              style: TextStyle(
                  fontSize: 36,
                  color: Color.fromRGBO(245, 91, 75, 1),
                  fontFamily: 'PottaOne'),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'lib/images/splash.png',
              height: 240,
            ),
            const SizedBox(
              height: 70,
              child: LoadingIndicator(
                indicatorType: Indicator.ballPulseSync,
                colors: [Color.fromRGBO(245, 91, 75, 1)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
