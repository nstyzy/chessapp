import 'package:chessapp/components/colors.dart';
import 'package:chessapp/components/helper.dart';
import 'package:chessapp/components/piece.dart';
import 'package:chessapp/components/square.dart';
import 'package:flutter/material.dart';

class Train extends StatefulWidget {
  const Train({super.key});

  @override
  State<Train> createState() => _TrainState();
}

class _TrainState extends State<Train> {
  // Список, представляющий шахматную доску, где каждая позиция может содержать шахматную фигуру
  late List<List<ChessPiece?>> board;

  bool showChampionMessage = false;

  List<int>? threateningPiecePosition;

  List<int>? findThreateningPiece(int row, int col) {
    // Проверяем каждую клетку на доске
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        ChessPiece? piece = board[r][c];
        if (piece != null && piece.isWhite != board[row][col]?.isWhite) {
          // Если фигура противника, проверяем, может ли она атаковать клетку
          List<List<int>> moves = calculateRawValidMoves(r, c, piece);
          for (var move in moves) {
            if (move[0] == row && move[1] == col) {
              return [r, c]; // Возвращаем позицию угрожающей фигуры
            }
          }
        }
      }
    }
    return null;
  }

  // Текущая выбранная фигура на шахматной доске
  ChessPiece? selectedPiece;

  // Индекс строки выбранного фрагмента
  // Значение по умолчанию -1 указывает, что в данный момент фигура не выбрана
  int selectedRow = -1;
  int selectedCol = -1;

  // Список допустимых ходов для выбранной в данный момент фигуры. Каждый ход представлен списком с двумя элементами: строкой и столбцом
  List<List<int>> validMoves = [];

  String message = 'Как белым добиться приемущества?';

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    List<List<ChessPiece?>> newBoard =
        List.generate(8, (index) => List.generate(8, (index) => null));

// пешка

    newBoard[1][0] = ChessPiece(
      type: ChessPieceType.pawm,
      isWhite: false,
      imagePath: 'lib/images/pawn.png',
    );
    newBoard[1][1] = ChessPiece(
      type: ChessPieceType.pawm,
      isWhite: false,
      imagePath: 'lib/images/pawn.png',
    );
    newBoard[1][5] = ChessPiece(
      type: ChessPieceType.pawm,
      isWhite: false,
      imagePath: 'lib/images/pawn.png',
    );
    newBoard[2][3] = ChessPiece(
      type: ChessPieceType.pawm,
      isWhite: false,
      imagePath: 'lib/images/pawn.png',
    );
    newBoard[1][6] = ChessPiece(
      type: ChessPieceType.pawm,
      isWhite: false,
      imagePath: 'lib/images/pawn.png',
    );
    newBoard[1][7] = ChessPiece(
      type: ChessPieceType.pawm,
      isWhite: false,
      imagePath: 'lib/images/pawn.png',
    );
    newBoard[6][0] = ChessPiece(
        type: ChessPieceType.pawm,
        isWhite: true,
        imagePath: 'lib/images/pawn.png');
    newBoard[6][1] = ChessPiece(
        type: ChessPieceType.pawm,
        isWhite: true,
        imagePath: 'lib/images/pawn.png');
    newBoard[3][3] = ChessPiece(
        type: ChessPieceType.pawm,
        isWhite: true,
        imagePath: 'lib/images/pawn.png');
    newBoard[6][5] = ChessPiece(
        type: ChessPieceType.pawm,
        isWhite: true,
        imagePath: 'lib/images/pawn.png');
    newBoard[6][6] = ChessPiece(
        type: ChessPieceType.pawm,
        isWhite: true,
        imagePath: 'lib/images/pawn.png');
    newBoard[6][7] = ChessPiece(
        type: ChessPieceType.pawm,
        isWhite: true,
        imagePath: 'lib/images/pawn.png');

// слон
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png');
    newBoard[0][5] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png');
    newBoard[7][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png');
    newBoard[7][5] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png');

// конь
    newBoard[3][4] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: 'lib/images/knight.png');
    newBoard[4][3] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'lib/images/knight.png');

// ладья
    newBoard[1][4] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'lib/images/bishop.png');
    newBoard[2][6] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'lib/images/bishop.png');
    newBoard[6][4] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'lib/images/bishop.png');
    newBoard[5][4] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'lib/images/bishop.png');

// король
    newBoard[0][6] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: false,
        imagePath: 'lib/images/king.png');
    newBoard[7][6] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: true,
        imagePath: 'lib/images/king.png');

// королева
    newBoard[0][3] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: false,
        imagePath: 'lib/images/queen.png');
    newBoard[7][3] = ChessPiece(
        type: ChessPieceType.queen,
        isWhite: true,
        imagePath: 'lib/images/queen.png');

    board = newBoard;
  }

  void pieceSelected(int row, int col) {
    setState(() {
      // Проверяем, есть ли фигура на клетке и соответствует ли она цвету текущего хода
      if (board[row][col] != null && board[row][col]!.isWhite) {
        // Если выбрана другая фигура того же цвета, обновляем выбор
        if (selectedPiece != null && board[row][col] != selectedPiece) {
          selectedPiece = board[row][col];
          selectedRow = row;
          selectedCol = col;
          validMoves = calculateRealValidMoves(
              selectedRow, selectedCol, selectedPiece, true);
        } else if (selectedPiece == null || board[row][col] == selectedPiece) {
          // Если фигура не была выбрана или выбрана та же фигура, обновляем выбор
          selectedPiece = board[row][col];
          selectedRow = row;
          selectedCol = col;
          validMoves = calculateRealValidMoves(
              selectedRow, selectedCol, selectedPiece, true);
        }
      } else if (selectedPiece != null) {
        // Если выбрана фигура, проверяем, является ли клетка допустимым ходом
        if (validMoves
            .any((element) => element[0] == row && element[1] == col)) {
          movePiece(row, col);
        }
        // Сброс выбора, если клетка не является допустимым ходом
        selectedPiece = null;
        selectedRow = -1;
        selectedCol = -1;
        validMoves = [];
      }
    });
  }

  // вычисляем возможные ходы фигур
  List<List<int>> calculateRawValidMoves(int row, int col, ChessPiece? piece) {
    List<List<int>> candidateMoves = [];

    if (piece == null) {
      return [];
    }

    int direction = piece.isWhite ? -1 : 1;

    switch (piece.type) {
      // ХОДЫ ПЕШКИ

      case ChessPieceType.pawm:
        // пешка может двигаться вперед, если клетка не занята
        if (isInBoard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + direction, col]);
        }

        // пешка может передвинуться на 2 клетки назад, если они находятся в исходной позиции
        if ((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
          if (isInBoard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
          }
        }

        // пешка может убивать по диагонали
        if (isInBoard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col - 1]);
        }
        if (isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.isWhite != piece.isWhite) {
          candidateMoves.add([row + direction, col + 1]);
        }
        break;

      // ХОДЫ СЛОНА

      case ChessPieceType.rook:
        var directions = [
          [-1, 0],
          [1, 0],
          [0, -1],
          [0, 1],
        ];
        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]);
              }
              break;
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;

      // ХОДЫ КОНЯ

      case ChessPieceType.knight:
        var knightMoves = [
          [-2, -1],
          [-2, 1],
          [-1, -2],
          [-1, 2],
          [1, -2],
          [1, 2],
          [2, -1],
          [2, 1],
        ];
        for (var move in knightMoves) {
          var newRow = row + move[0];
          var newCol = col + move[1];
          if (!isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]);
            }
            continue;
          }
          candidateMoves.add([newRow, newCol]);
        }
        break;

      // ХОДЫ ЛАДЬИ

      case ChessPieceType.bishop:
        var directions = [
          [-1, -1],
          [-1, 1],
          [1, -1],
          [1, 1],
        ];
        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]);
              }
              break;
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;

      // ХОДЫ КОРОЛЕВЫ

      case ChessPieceType.queen:
        var directions = [
          [-1, 0],
          [1, 0],
          [0, -1],
          [0, 1],
          [-1, -1],
          [-1, 1],
          [1, -1],
          [1, 1],
        ];
        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]);
              }
              break;
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;

      // ХОДЫ КОРОЛЯ

      case ChessPieceType.king:
        var directions = [
          [-1, 0],
          [1, 0],
          [0, -1],
          [0, 1],
          [-1, -1],
          [-1, 1],
          [1, -1],
          [1, 1],
        ];
        for (var direction in directions) {
          var newRow = row + direction[0];
          var newCol = col + direction[1];
          if (!isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]);
            }
            continue;
          }
          candidateMoves.add([newRow, newCol]);
        }
        break;
      default:
    }

    return candidateMoves;
  }

  // вычисляем правильные ходы фигур
  List<List<int>> calculateRealValidMoves(
      int row, int col, ChessPiece? piece, bool checkSimulation) {
    List<List<int>> realValidMoves = [];
    List<List<int>> candidateMoves = calculateRawValidMoves(row, col, piece);

    // после генерации всех ходов, вычисляем те, корые могут привести к шаху
    if (checkSimulation) {
      for (var move in candidateMoves) {
        int endRow = move[0];
        int endCol = move[1];

        // генерируем ход, который будет безопасен для короля
        if (simulatedMoveIsSafe(piece!, row, col, endRow, endCol)) {
          realValidMoves.add(move);
        }
      }
    } else {
      realValidMoves = candidateMoves;
    }
    return realValidMoves;
  }

  void autoMoveKnight() {
    // Найти позицию коня на e5
    int knightRow = 3; // 4-й ряд снизу
    int knightCol = 4; // 5-й столбец слева (e)
    // Переместить коня на d7
    setState(() {
      board[1][3] = board[knightRow][knightCol]; // Позиция d7
      board[knightRow][knightCol] = null;
      message = 'Продолжай захватывать поле';
    });
  }

  void movePiece(int newRow, int newCol) {
    // Сохраняем исходные координаты и ссылку на фигуру
    int originalRow = selectedRow;
    int originalCol = selectedCol;
    ChessPiece? movingPiece = selectedPiece;

    // Проверка хода пешкой с f2 на f4
    bool isPawnMoveFromF2ToF4 = selectedPiece?.type == ChessPieceType.pawm &&
        selectedRow == 6 &&
        selectedCol == 5 && // Позиция f2
        newRow == 4 &&
        newCol == 5; // Позиция f4

    // Проверка хода коня с e5 на d7
    bool isKnightMoveFromE5ToD7 =
        selectedPiece?.type == ChessPieceType.knight &&
            selectedRow == 3 &&
            selectedCol == 4 && // Позиция e5
            newRow == 1 &&
            newCol == 3; // Позиция d7

    // Проверка хода пешкой с f4 на f5
    bool isPawnMoveFromF4ToF5 = selectedPiece?.type == ChessPieceType.pawm &&
        selectedRow == 4 &&
        selectedCol == 5 && // Позиция f4
        newRow == 3 &&
        newCol == 5; // Позиция f5
    if (threateningPiecePosition != null &&
        threateningPiecePosition![0] == newRow &&
        threateningPiecePosition![1] == newCol) {
      setState(() {
        message = 'Ошибка: Фигура может убить фигуру игрока';
      });
    } else {
      setState(() {
        message = 'Подумай еще';
      });
    }

    if (isPawnMoveFromF2ToF4) {
      setState(() {
        message = 'Верный ход!';
        // Перемещаем фигуру
        board[newRow][newCol] = selectedPiece;
        board[originalRow][originalCol] = null;
        // Запуск автоматического хода коня через секунду
        Future.delayed(const Duration(seconds: 1), () {
          autoMoveKnight();
        });
      });
    } else if (isKnightMoveFromE5ToD7) {
      setState(() {
        message = 'Продолжай захватывать поле';
        // Перемещаем фигуру
        board[newRow][newCol] = selectedPiece;
        board[originalRow][originalCol] = null;
      });
    } else if (isPawnMoveFromF4ToF5) {
      setState(() {
        message = 'Ты чемпион';
        showChampionMessage = true;
        // Перемещаем фигуру
        board[newRow][newCol] = selectedPiece;
        board[originalRow][originalCol] = null;
      });
    } else {
      // Перемещаем фигуру
      board[newRow][newCol] = selectedPiece;
      board[originalRow][originalCol] = null;
      // Обновляем состояние до задержки
      setState(() {
        threateningPiecePosition = findThreateningPiece(newRow, newCol);
      });
      // Возвращаем фигуру на исходную позицию через 1 секунду, если ход неверный
      Future.delayed(const Duration(seconds: 1), () {
        // Проверяем, что фигура все еще существует
        if (movingPiece != null) {
          setState(() {
            // Возвращаем фигуру на исходную позицию
            board[originalRow][originalCol] = movingPiece;
            board[newRow][newCol] = null;
            message = 'Как белым добиться приемущества?';
            // Сброс подсветки угрожающей фигуры
            threateningPiecePosition = null;
          });
        }
      });
    }

    // Сброс выбора
    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });
  }

  // проверяем, аттакован ли король
  bool isKingInCheck(bool isWhiteKing) {
    //определяем позицию короля

    return false;
  }

  // МОДЕЛИРУЕМ БУДУЩИЙ ХОД, ЧТОБЫ ПРОВЕРИТЬ, БЕЗОПАСЕН ЛИ ОН (НЕ ПОДСТАВЛЯЕТ НАПАДЕНИЮ НА СОБСТВЕННОГО КОРОЛЯ)
  bool simulatedMoveIsSafe(
      ChessPiece piece, int startRow, int startCol, int endRow, int endCol) {
// сохраняем текущее состояние доски
    ChessPiece? originalDestinationPiece = board[endRow][endCol];

    // симулируем ход
    board[endRow][endCol] = piece;
    board[startRow][startCol] = null;

    // проверяем, атакован ли наш король
    bool kingInCheck = isKingInCheck(piece.isWhite);

    // восстанавливаем доску в исходное состояние
    board[startRow][startCol] = piece;
    board[endRow][endCol] = originalDestinationPiece;

    // если король под шахом = правда, значит - это небезопасный ход
    return !kingInCheck;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.black, child: const Text('Нужно подумать!')),
      ),
      backgroundColor: bacgroundColour,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
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
                for (var position in validMoves) {
                  if (position[0] == row && position[1] == col) {
                    isValidMove = true;
                  }
                }
                return Square2(
                  isWhite: isWhite(index),
                  piece: board[row][col],
                  isSelected: isSelected,
                  isValidMove: isValidMove,
                  isThreatened: threateningPiecePosition != null &&
                      threateningPiecePosition![0] == row &&
                      threateningPiecePosition![1] == col,
                  onTap: () => pieceSelected(row, col),
                  row: row,
                  col: col,
                );
              },
            ),
          ),
          if (showChampionMessage)
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Последний ход "16. f5" белых позволяет им создать угрозу и атаковать черного коня на поле g6. Этот ход также открывает линию для ферзя белых на диагонали h2-b8, что может быть использовано для дальнейших атак. Плюс, белые начинают активную атаку на королевском фланге. Исход игры может быть различным в зависимости от того, как продолжится игра. В данной ситуации белые имеют преимущество в развитии и активной позиции, однако черные могут попытаться обороняться и контратаковать. На данный момент позиция сложная, и многое будет зависеть от последующих ходов обеих сторон.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Завершить')),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
