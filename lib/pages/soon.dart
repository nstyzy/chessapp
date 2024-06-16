import 'package:flutter/material.dart';

class Comming extends StatelessWidget {
  const Comming({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Scaffold(body: Center(child: Text('Что-то очень хорошее появится совсем скоро!'),),),
    );
  }
}