import 'package:chessapp/pages/soon.dart';
import 'package:chessapp/pages/train.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Color(0x3416202A),
              offset: Offset(0.0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                child: Text(title),
              ),
              const Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0.9, 0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF57636C),
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Trains extends StatelessWidget {
  const Trains({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(245, 91, 75, 1),
        title: const Text(
          "Тренажеры",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomCard(
                        title: 'Защита Алехина',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Train()));
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCard(
                        title: 'Защита Бенони',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comming()));
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCard(
                        title: 'Дебют Берда',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comming()));
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCard(
                        title: 'Дебют слона',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comming()));
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCard(
                        title: 'Гамбит Боголюбова',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comming()));
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCard(
                        title: 'Центральный гамбит',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comming()));
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCard(
                        title: 'Голландская защита',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comming()));
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCard(
                        title: 'Гамбит Эванса',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comming()));
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCard(
                        title: 'Итальянская партия',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comming()));
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCard(
                        title: 'Латышский гамбит',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comming()));
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCard(
                        title: 'Защита Филидора',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comming()));
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomCard(
                        title: 'Дебют Рети',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Comming()));
                        },
                      ),
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
