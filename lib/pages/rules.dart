import 'package:chessapp/components/colors.dart';
import 'package:chessapp/components/dead_piece.dart';
import 'package:chessapp/components/helper.dart';
import 'package:chessapp/components/piece.dart';
import 'package:chessapp/components/square.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // Список, представляющий шахматную доску, где каждая позиция может содержать шахматную фигуру
  late List<List<ChessPiece?>> board;

  // Текущая выбранная фигура на шахматной доске
  ChessPiece? selectedPiece;

  // Индекс строки выбранного фрагмента
  // Значение по умолчанию -1 указывает, что в данный момент фигура не выбрана
  int selectedRow = -1;
  int selectedCol = -1;

  // Список допустимых ходов для выбранной в данный момент фигуры. Каждый ход представлен списком с двумя элементами: строкой и столбцом
  List<List<int>> validMoves = [];

  // Список белых фигур, взятых черными
  List<ChessPiece> whitePiecesTaken = [];

  // Список черных фигур, взятых белыми
  List<ChessPiece> blackPiecesTaken = [];

  // Определение очереди ходов
  bool isWhiteTurn = true;

  //начальное положение королей
  List<int> whiteKingPosition = [7, 4];
  List<int> blackKingPosition = [0, 4];
  bool checkStatus = false;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    List<List<ChessPiece?>> newBoard =
        List.generate(8, (index) => List.generate(8, (index) => null));

// пешка
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
        type: ChessPieceType.pawm,
        isWhite: false,
        imagePath: 'lib/images/pawn.png',
      );
      newBoard[6][i] = ChessPiece(
          type: ChessPieceType.pawm,
          isWhite: true,
          imagePath: 'lib/images/pawn.png');
    }
// слон
    newBoard[0][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png');
    newBoard[0][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: false,
        imagePath: 'lib/images/rook.png');
    newBoard[7][0] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png');
    newBoard[7][7] = ChessPiece(
        type: ChessPieceType.rook,
        isWhite: true,
        imagePath: 'lib/images/rook.png');

// конь
    newBoard[0][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: 'lib/images/knight.png');
    newBoard[0][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: false,
        imagePath: 'lib/images/knight.png');
    newBoard[7][1] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'lib/images/knight.png');
    newBoard[7][6] = ChessPiece(
        type: ChessPieceType.knight,
        isWhite: true,
        imagePath: 'lib/images/knight.png');

// ладья
    newBoard[0][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'lib/images/bishop.png');
    newBoard[0][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: false,
        imagePath: 'lib/images/bishop.png');
    newBoard[7][2] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'lib/images/bishop.png');
    newBoard[7][5] = ChessPiece(
        type: ChessPieceType.bishop,
        isWhite: true,
        imagePath: 'lib/images/bishop.png');

// король
    newBoard[0][4] = ChessPiece(
        type: ChessPieceType.king,
        isWhite: false,
        imagePath: 'lib/images/king.png');
    newBoard[7][4] = ChessPiece(
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
      if (selectedPiece == null && board[row][col] != null) {
        if (board[row][col]!.isWhite == isWhiteTurn) {
          selectedPiece = board[row][col];
          selectedRow = row;
          selectedCol = col;
        }
      } else if (board[row][col] != null &&
          board[row][col]!.isWhite == selectedPiece!.isWhite) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      } else if (selectedPiece != null &&
          validMoves.any((element) => element[0] == row && element[1] == col)) {
        movePiece(row, col);
      }

      // Если фигура выбрана, вычисляются возможные ходы
      validMoves = calculateRealValidMoves(
          selectedRow, selectedCol, selectedPiece, true);
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

  //ходы фигур
  void movePiece(int newRow, int newCol) {
    // если в возможном ходе есть фигура противника
    if (board[newRow][newCol] != null) {
      // добавляем убитую фигуру в список
      var capturedPiece = board[newRow][newCol];
      if (capturedPiece!.isWhite) {
        whitePiecesTaken.add(capturedPiece);
      } else {
        blackPiecesTaken.add(capturedPiece);
      }
    }

    // проверяем, будет ли фигура бить короля
    if (selectedPiece!.type == ChessPieceType.king) {
      // обновляем соответсвующую позицию короля
      if (selectedPiece!.isWhite) {
        whiteKingPosition = [newRow, newCol];
      } else {
        blackKingPosition = [newRow, newCol];
      }
    }

    //перемещаем фигуру и удаляем старую
    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    //проверяем, находится ли король под аттакой
    if (isKingInCheck(!isWhiteTurn)) {
      checkStatus = true;
    } else {
      checkStatus = false;
    }

    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });

    // проверяем, мат ли это
    if (isCheckMate(!isWhiteTurn)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("ШАХ И МАТ"),
          actions: [
            // Кнопка начать снова
            TextButton(onPressed: resetGame, child: const Text("Начать снова"))
          ],
        ),
      );
    }

    // Меняем ходы
    isWhiteTurn = !isWhiteTurn;
  }

  // проверяем, аттакован ли король
  bool isKingInCheck(bool isWhiteKing) {
    //определяем позицию короля
    List<int> kingPosition =
        isWhiteKing ? whiteKingPosition : blackKingPosition;

    //проверяем, может ли какая-либо фигура аттаковать короля
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        // пропускаем пустые поля и фигуры того же цвета
        if (board[i][j] == null || board[i][j]!.isWhite == isWhiteKing) {
          continue;
        }

        List<List<int>> pieceValidMoves =
            calculateRealValidMoves(i, j, board[i][j], false);

        // проверяем, находится ли король в допустимых для фигуры ходах
        if (pieceValidMoves.any((move) =>
            move[0] == kingPosition[0] && move[1] == kingPosition[1])) {
          return true;
        }
      }
    }
    return false;
  }

  // МОДЕЛИРУЕМ БУДУЩИЙ ХОД, ЧТОБЫ ПРОВЕРИТЬ, БЕЗОПАСЕН ЛИ ОН (НЕ ПОДСТАВЛЯЕТ НАПАДЕНИЮ НА СОБСТВЕННОГО КОРОЛЯ)
  bool simulatedMoveIsSafe(
      ChessPiece piece, int startRow, int startCol, int endRow, int endCol) {
// сохраняем текущее состояние доски
    ChessPiece? originalDestinationPiece = board[endRow][endCol];

// если фигура король, сохранить ее текущую позицию и обновить ее до новой
    List<int>? originalKingPosition;
    if (piece.type == ChessPieceType.king) {
      originalKingPosition =
          piece.isWhite ? whiteKingPosition : blackKingPosition;

      // обновляем позицию короля
      if (piece.isWhite) {
        whiteKingPosition = [endRow, endCol];
      } else {
        blackKingPosition = [endRow, endCol];
      }
    }

    // симулируем ход
    board[endRow][endCol] = piece;
    board[startRow][startCol] = null;

    // проверяем, атакован ли наш король
    bool kingInCheck = isKingInCheck(piece.isWhite);

    // восстанавливаем доску в исходное состояние
    board[startRow][startCol] = piece;
    board[endRow][endCol] = originalDestinationPiece;

    // если фигура была королем, восстанавливаем ее
    if (piece.type == ChessPieceType.king) {
      if (piece.isWhite) {
        whiteKingPosition = originalKingPosition!;
      } else {
        blackKingPosition = originalKingPosition!;
      }
    }

    // если король под шахом = правда, значит - это небезопасный ход
    return !kingInCheck;
  }

  // Это шах и мат?
  bool isCheckMate(bool isWhiteKing) {
    // если корлоль не под шахом, это не мат
    if (!isKingInCheck(isWhiteKing)) {
      return false;
    }

    // если хотя бы одна фигура может сделать верный ход, это не мат
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        // пропускаем пустые клетки и фигуры того же цвета
        if (board[i][j] == null || board[i][j]!.isWhite != isWhiteKing) {
          continue;
        }

        List<List<int>> pieceValidMoves =
            calculateRealValidMoves(i, j, board[i][j], true);

        // если эта фигура может сделать верный ход, это не мат
        if (pieceValidMoves.isNotEmpty) {
          return false;
        }
      }
    }

    // если не одно из условий не выполнено, верных ходов нет
    // это мат
    return true;
  }

// Начать новую игру
  void resetGame() {
    Navigator.pop(context);
    _initializeBoard();
    checkStatus = false;
    whitePiecesTaken.clear();
    blackPiecesTaken.clear();
    whiteKingPosition = [7, 4];
    blackKingPosition = [0, 4];
    isWhiteTurn = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.black, child: const Text('Время игры')),
        centerTitle: true,
      ),
      backgroundColor: bacgroundColour,
      body: Center(
        child: Column(
          children: [
            // Взятые белые фигуры
            Expanded(
              flex: 1,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
                child: GridView.builder(
                  itemCount: whitePiecesTaken.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8),
                  itemBuilder: (context, index) => DeadPiece(
                    imagePath: whitePiecesTaken[index].imagePath,
                    isWhite: true,
                  ),
                ),
              ),
            ),

            // Статус игры
            Text(checkStatus ? "ШАХ!" : ""),

            // Шахматная доска
            Expanded(
              flex: 5,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
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
                    return Square(
                      isWhite: isWhite(index),
                      piece: board[row][col],
                      isSelected: isSelected,
                      isValidMove: isValidMove,
                      onTap: () => pieceSelected(row, col),
                      row: row,
                      col: col,
                    );
                  },
                ),
              ),
            ),

            // Взятые черные фигуры
            Expanded(
              flex: 1,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
                child: GridView.builder(
                  itemCount: blackPiecesTaken.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 8),
                  itemBuilder: (context, index) => DeadPiece(
                    imagePath: blackPiecesTaken[index].imagePath,
                    isWhite: false,
                  ),
                ),
              ),
            ),
            // Кнопка "Начать с начала"
          ],
        ),
      ),
    );
  }
}
