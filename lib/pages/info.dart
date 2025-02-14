import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final List<String> chessTerms = [
    "Битое поле - шахматное поле, которое контролируется фигурой или пешкой.",
    "Вечный шах - серия непрерывных шахов, от которых невозможно уйти.",
    "Взятие - уничтожение чужой фигуры или пешки.",
    "Вилка - одновременное нападение на две фигуры и более.",
    "Вскрытый шах - нападение вскрываемой фигуры на короля.",
    "Двойной шах - одновременный шах двумя фигурами.",
    "Детский мат - один из самых простых и быстрых матов в начале игры.",
    "Качество - соотношение сил, разница между ладьей и конем или слоном.",
    "Легкие фигуры - слоны и кони.",
    "Линейный мат - мат двумя ладьями (ферзем и ладьей), когда те стоят на соседних линиях, а король слабейшей стороны расположен на одной из них.",
    "Мат - неотразимое нападение на короля, шах от которого нет защиты.",
    "Материальное преимущество - превосходство в количестве фигур или пешек.",
    "Нотация - способ записи шахматной партии и отдельных ходов.",
    "Оппозиция - противостояние королей.",
    "Пат - положение, когда королю некуда ходить, но при этом он не под шахом.",
    "Позиция - размещение фигур и пешек на шахматной доске.",
    "Превращение пешки - замена пешки, достигшей последней линии, фигурой.",
    "Развитие - ввод фигур в игру.",
    "Размен - обмен своей фигуры на фигуру соперника.",
    "Рокировка - одновременный ход королем и ладьей.",
    "Связанная фигура - фигура, прикрывающая от нападения другую фигуру.",
    "Связка - нападение на фигуру или пешку, за которой по линии нападения находится другая фигура, обычно более ценная.",
    "Соседние поля - шахматный поля, соприкасающиеся друг с другом.",
    "Тяжелые фигуры - ферзь и ладьи.",
    "Цейтнот - острый недостаток времени на обдумывание ходов.",
    "Цугцванг - положение, когда игрок вынужден сделать плохой ход.",
    "Шах - нападение чужой фигуры на короля."
  ];

  Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Условные обозначения',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color.fromRGBO(69, 201, 142, 1),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: chessTerms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(chessTerms[index]),
          );
        },
      ),
    );
  }
}
