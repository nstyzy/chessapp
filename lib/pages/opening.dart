import 'package:chessapp/components/colors.dart';
import 'package:chessapp/components/helper.dart';
import 'package:chessapp/components/piece.dart';
import 'package:chessapp/components/square.dart';
import 'package:chessapp/pages/catalog/open.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Debut extends StatefulWidget {
  const Debut({super.key});

  @override
  State<Debut> createState() => _DebutState();
}

class _DebutState extends State<Debut> {
  late List<List<ChessPiece?>> board;

  bool isFinished = false;

  int selectedRow = -1;

  int selectedCol = -1;

  int currentTextIndex = 0;

  double percent = 0.0;

  bool isFirstMove = true;

  String additionalText = '';

  List<String> textList = [
    '1. f5',
    '... f4',
    '2. Nf6 \ne3 — наивный на вид ход, который мы также рассмотрим в основном курсе.',
    '... Nc3 \nМы планируем сыграть... e4 в ответ на b6, поэтому ждем, пока белые сделают этот ход. Если белые не сыграют b6, мы последуем...Nf3. \n Важно начать с 2...Nc3, потому что, если белые сыграют 3.b6, мы готовы сыграть ...e4, прежде чем белые смогут создать закрытая центральная позиция с Bb7',
    '3. b6',
    '... e4',
    '4. cxe4',
    '... Nxe4',
    '5. Bb7',
    '... Nf2 \nNf2 разыгрывается с простой идеей: следующим сыграть ...d4 и получить контроль над центром. Если белые выберут Nc6, мы можем сыграть...Nf3 и повторить угрозу хода...d4.',
    '6. Nc6 \nВ основном курсе мы также подробно рассмотрим другие варианты белых, такие как 6.Qg6 и 6.e6.',
    '... f3 \nМы возобновляем угрозу ..d4.',
    '7. h6 \n0-0 и e6  более популярны, но в тренде ход 7. h6. Так что это можно считать современным способом игры против этой системы. Идея состоит в том, чтобы встретить ...d4 немедленным g5',
    '... b3 \nБелые предвидели ...d4 и потратили ход h7, чтобы отговорить черных от игры...d4, подготовив g5. Теперь ожидаем g5 и меняем план. Вместо этого мы выбираем...b3 и ...Bb2, останавливая единственный план белых сыграть g5 и делая ход 7.h6 совершенно бесполезным.',
    '8. a5 \nС каждым ходом мы получаем новую позицию с разной динамикой, и на основе этого фактора делаются ходы. До сих пор a5 был немного бесцельным, но сейчас он наиболее критичен. У белых есть простая угроза пойти следующим ходом a4',
    '... Bb5 \nСамый естественный ход в позиции. Остановим идею белых, развивая фигуру.',
    '9. Qg6',
    '... Bb2 \nПришло время игнорировать пешку и сосредоточиться на развитии . 9... Qf1 - лучший вариант, с чем, боюсь, придется не согласиться. 9...Bb2 доставит белым неприятности, как мы скоро увидим.',
    '10. Qxg2 \nДругого объяснения предыдущего хода белых нет. Мы также угрожали стратегическим ходом...Bxc6 с последующим...Ne5, навсегда разрушающим пешечную структуру белых.',
    '... Be2 \nУгроза ...Rg1 вынуждает белых отойти ферзем.',
    '11. Qg6',
    '... Rg1 \nМы развиваем еще одну фигуру с темпом',
    '12. Qe8',
    '... a3 \nЕсть много вариантов, которые существуют у черных для получения хорошей позиции, но этот мне нравится больше всего',
    '13. e6',
    '... O-O \nМы могли бы также продолжить с идей ...Nd3-e5, но этот ход является самым простыми и логичными.',
    '14. O-O',
    '... Nd3 \nМы хотим сыграть... Nde5, заботясь о слабом поле g6. Белые не могут переместить слона f1, так как пешка g7 остается незащищенной',
    '15. Ne7',
    '... d4',
    '16. Nf5 \nc5 Nb5 выглядело невыгодно, поэтому белые выбрали вариант ликвидации',
    '... Nxf5',
    '17. dxf5',
    '... Ne5 \nКонь занимает удобное поле e5. Теперь мы намерены сыграть...Bb5. В жизни ладьи h8 слона f8 ничего особенного не изменилось. Они все еще ждут работу получше, чем присматривать за пешкой g7.',
    '18. Rg8 \nПытаемся освободить слона f8 и избежать хода ...Ng6.',
    '... Bb5 \n...Nxd7+ теперь становится серьёзной угрозой.',
    '19. Bd6 \nc6 Bd3 практически уничтожило бы единственного активного слона белых, так что это исключено. Теперь белые собираются сыграть g5 и жертвуют пешку d7, чтобы получить активную игру.',
    '... h4 \nNxd7+ заканчивалось бы ничьей, но зачем допускать такую игру? Спешки нет, и белые практически застряли. Мы не согласны с упрощением позиции. Мы не позволяем белым сыграть g5 и просим их показать некоторые планы',
    '20. Rd8 \nПосмотрите на этих бедных ладей. Какой у них профиль работы!',
    '... Ka2 \nДоступны различные планы, но я предпочитаю этот, который демонстрирует отсутствие срочности и полное спокойствие, когда мы под защитой пешек. Приглашаем белых продемонстрировать свои планы, а сами медленно инициируем атаку на каждом участке доски.',
    '21. Ka7 \nБелые совершают эти бесцельные движения, которые трудно объяснить и очень трудно понять. Чего нельзя сказать о черных, поскольку у нас много атакующих идей, а белые их просто ждут.',
    '... Bc4 \nОпять слишком много вариантов на выбор, и не стесняйтесь выбирать все, что вы думаете. Здесь нет так называемого правильного или единственного хода. Это дело вкуса, как вы хотите двигаться дальше',
    '22. Bd5',
    '... Qf1 \nМы прокладываем путь для... Re1, чтобы преследовать ферзя. Удаление белопольного слона также улучшит наши шансы на атаку на королевском фланге. Очевидно, что игра за черных более прямолинейна. \nПозиция белых более хрупкая, и ошибки могут дорого стоить , в то время как у черных больше места для ошибок и все еще есть хорошие практические шансы начать успешную атаку на всех участках доски',
  ];

  List<List<dynamic>> moves = [
    // Список ходов в последовательности
    ['1', '5', '3', '5'],
    ['6', '5', '4', '5'],
    ['0', '6', '2', '5'],
    ['7', '1', '5', '2'],
    ['1', '1', '2', '1'],
    ['6', '4', '4', '4'],
    ['3', '5', '4', '4'],
    ['5', '2', '4', '4'],
    ['0', '2', '1', '1'],
    ['4', '4', '6', '5'],
    ['0', '1', '2', '2'],
    ['7', '6', '5', '5'],
    ['1', '7', '2', '7'],
    ['6', '1', '5', '1'],
    ['1', '0', '3', '0'],
    ['7', '5', '3', '1'],
    ['0', '4', '2', '6'],
    ['7', '2', '6', '1'],
    ['2', '6', '6', '6'],
    ['3', '1', '6', '4'],
    ['6', '6', '2', '6'],
    ['7', '7', '7', '6'],
    ['2', '6', '0', '4'],
    ['6', '0', '5', '0'],
    ['1', '4', '2', '4'],
    ['7', '3', '7', '1'],
    ['0', '3', '0', '1'],
    ['6', '5', '5', '3'],
    ['2', '2', '1', '4'],
    ['5', '5', '4', '3'],
    ['1', '4', '3', '5'],
    ['4', '3', '3', '5'],
    ['2', '4', '3', '5'],
    ['5', '3', '3', '4'],
    ['0', '7', '0', '6'],
    ['6', '4', '3', '1'],
    ['0', '5', '2', '3'],
    ['6', '7', '4', '7'],
    ['0', '2', '0', '3'],
    ['7', '1', '6', '0'],
    ['0', '1', '1', '0'],
    ['3', '1', '4', '2'],
    ['1', '1', '3', '3'],
    ['7', '4', '7', '5'],
  ];

  List<String> displayedTextList = [];

  int currentMoveIndex = 0; // Индекс текущего хода

  void makeMove(int sourceRow, int sourceCol, int targetRow, int targetCol) {
    setState(() {
      // Сохраняем ход и сбитую фигуру
      ChessPiece? capturedPiece = board[targetRow][targetCol];
      if (capturedPiece != null) {
        if (capturedPiece.isWhite) {
          whitePiecesTaken.add(capturedPiece);
        } else {
          blackPiecesTaken.add(capturedPiece);
        }
      }
      moves.add(
          [sourceRow, sourceCol, targetRow, targetCol, capturedPiece?.clone()]);

      // Выполняем ход
      board[targetRow][targetCol] = board[sourceRow][sourceCol];
      board[sourceRow][sourceCol] = null;
    });
  }

  List<ChessPiece> whitePiecesTaken = [];
  List<ChessPiece> blackPiecesTaken = [];

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _savePercent(double percent) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('percent', percent);
  }

  void _initializeBoard() {
    List<List<ChessPiece?>> newBoard =
        List.generate(8, (index) => List.generate(8, (index) => null));

    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
        type: ChessPieceType.pawm,
        isWhite: true,
        imagePath: 'lib/images/pawn.png',
      );
      newBoard[6][i] = ChessPiece(
          type: ChessPieceType.pawm,
          isWhite: false,
          imagePath: 'lib/images/pawn.png');
    }
// слон
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png');
    newBoard[0][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png');
    newBoard[7][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png');
    newBoard[7][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png');

// конь
    newBoard[0][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'lib/images/knight.png');
    newBoard[0][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'lib/images/knight.png');
    newBoard[7][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: 'lib/images/knight.png');
    newBoard[7][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: 'lib/images/knight.png');

// ладья
    newBoard[0][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'lib/images/bishop.png');
    newBoard[0][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'lib/images/bishop.png');
    newBoard[7][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'lib/images/bishop.png');
    newBoard[7][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'lib/images/bishop.png');

// король
    newBoard[0][3] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: true,
        imagePath: 'lib/images/king.png');
    newBoard[7][3] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: false,
        imagePath: 'lib/images/king.png');

// королева
    newBoard[0][4] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: true,
        imagePath: 'lib/images/queen.png');
    newBoard[7][4] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: false,
        imagePath: 'lib/images/queen.png');

    board = newBoard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Title(color: Colors.black, child: const Text('Английское начало')),
      ),
      backgroundColor: bacgroundColour,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Шахматная доска
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: 8 * 8,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8),
              itemBuilder: (context, index) {
                int row = index ~/ 8;
                int col = index % 8;

                bool isSelected = selectedRow == row && selectedCol == col;

                bool isValidMove = false;

                return Square(
                  isWhite: isWhite(index),
                  piece: board[row][col],
                  isSelected: isSelected,
                  isValidMove: isValidMove,
                  onTap: () {},
                  row: row,
                  col: col,
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: displayedTextList
                      .asMap()
                      .map((i, text) {
                        return MapEntry(
                            i,
                            Text(
                              text,
                              textAlign: TextAlign.left,
                              style: const TextStyle(color: Colors.white),
                            ));
                      })
                      .values
                      .toList(),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (currentMoveIndex < moves.length &&
                            currentTextIndex < textList.length) {
                          List move = moves[currentMoveIndex];
                          int sourceRow = int.parse(move[0]);
                          int sourceCol = int.parse(move[1]);
                          int targetRow = int.parse(move[2]);
                          int targetCol = int.parse(move[3]);

                          // Логика для рокировки
                          // Выполнение рокировки для белых
                          if (sourceRow == 7 &&
                              sourceCol == 3 &&
                              targetRow == 7 &&
                              targetCol == 1) {
                            // Выполнение рокировки для черных
                            board[7][1] = board[7][3]; // Перемещение короля
                            board[7][2] = board[7][0]; // Перемещение ладьи
                            board[7][3] = null;
                            board[7][0] = null;
                          } else if (sourceRow == 0 &&
                              sourceCol == 3 &&
                              targetRow == 0 &&
                              targetCol == 1) {
                            // Выполнение рокировки для белых
                            board[0][1] = board[0][3]; // Перемещение короля
                            board[0][2] = board[0][0]; // Перемещение ладьи
                            board[0][3] = null;
                            board[0][0] = null;
                          } else {
                            // Обычный ход без рокировки

                            // Перемещение фигуры в целевую ячейку
                            board[targetRow][targetCol] =
                                board[sourceRow][sourceCol];
                            // Очистка исходной ячейки
                            board[sourceRow][sourceCol] = null;
                          }
                          currentMoveIndex++;

                          additionalText += '${textList[currentTextIndex]}\n';

                          if (currentTextIndex % 2 == 0) {
                            displayedTextList.clear();
                          }
                          double newPercent =
                              (currentTextIndex + 1) / textList.length;
                          percent = newPercent.clamp(0.0, 1.0);
                          displayedTextList.add(textList[currentTextIndex]);
                          currentTextIndex++;
                        } else if (!isFinished) {
                          // Если это последний текст в списке и isFinished еще не true,
                          // устанавливаем isFinished в true и меняем текст кнопки на 'Завершить'
                          isFinished = true;
                          // Также устанавливаем процент выполнения в 1.0
                          percent = 1.0;
                          // Сохраняем процент выполнения
                          _savePercent(percent);
                        } else {
                          // Если isFinished уже true, переходим на другую страницу
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Open()));
                        }
                      });
                    },
                    child: Text(isFinished ? 'Завершить' : 'Показать ход'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LinearPercentIndicator(
                    lineHeight: 4,
                    percent: percent,
                    progressColor: const Color.fromRGBO(97, 30, 240, 1),
                    backgroundColor: const Color.fromARGB(255, 186, 160, 238),
                    barRadius: const Radius.circular(50),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
