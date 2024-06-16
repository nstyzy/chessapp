import 'package:chessapp/components/colors.dart';
import 'package:chessapp/components/piece.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final bool isValidMove;
  final void Function()? onTap;
  final int row;
  final int col;

  const Square({
    super.key,
    required this.isWhite,
    required this.piece,
    required this.isSelected,
    required this.onTap,
    required this.isValidMove,
    required this.row,
    required this.col,
  });

  @override
  Widget build(BuildContext context) {
    Color? squareColor;
    if (isSelected || isValidMove) {
      squareColor = const Color.fromRGBO(121, 74, 222, 1);
    } else {
      squareColor = isWhite ? foregroundColor : bacgroundColour;
    }

    String labelTop = '';
    String labelBottom = '';
    if (row == 7 && col == 0) {
      labelTop = 'A';
      labelBottom = '1';
    } else {
      if (row == 7) {
        labelTop = String.fromCharCode('A'.codeUnitAt(0) + col);
      } else if (col == 0) {
        labelBottom = '${8 - row}';
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        color: squareColor,
        margin: EdgeInsets.all(isValidMove ? 5 : 0),
        child: Stack(
          children: [
            if (labelTop.isNotEmpty)
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(
                  labelTop,
                  style: const TextStyle(
                      fontSize: 12, color: Color.fromRGBO(97, 30, 240, 1)),
                ),
              ),
            if (labelBottom.isNotEmpty)
              Positioned(
                top: 0,
                left: 0,
                child: Text(
                  labelBottom,
                  style: const TextStyle(
                      fontSize: 12, color: Color.fromRGBO(97, 30, 240, 1)),
                ),
              ),
            if (piece != null)
              Align(
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: 0.8,
                  child: Image.asset(
                    piece!.imagePath,
                    color: piece!.isWhite
                        ? const Color.fromRGBO(244, 247, 250, 1)
                        : const Color.fromRGBO(97, 30, 240, 1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Square2 extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final bool isValidMove;
  final bool isThreatened;
  final void Function()? onTap;
  final int row;
  final int col;

  const Square2({
    super.key,
    required this.isWhite,
    required this.piece,
    required this.isSelected,
    required this.onTap,
    required this.isValidMove,
    required this.isThreatened,
    required this.row,
    required this.col,
  });

  @override
  Widget build(BuildContext context) {
    Color? squareColor;
    if (isSelected || isValidMove) {
      squareColor = const Color.fromRGBO(121, 74, 222, 1);
    } else if (isThreatened) {
      // Проверка на угрозу
      squareColor = const Color.fromARGB(
          255, 217, 112, 238); // Красная подсветка для угрожаемой клетки
    } else {
      squareColor = isWhite ? foregroundColor : bacgroundColour;
    }

    String labelTop = '';
    String labelBottom = '';
    if (row == 7 && col == 0) {
      labelTop = 'A';
      labelBottom = '1';
    } else {
      if (row == 7) {
        labelTop = String.fromCharCode('A'.codeUnitAt(0) + col);
      } else if (col == 0) {
        labelBottom = '${8 - row}';
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        color: squareColor,
        margin: EdgeInsets.all(isValidMove ? 5 : 0),
        child: Stack(
          children: [
            if (labelTop.isNotEmpty)
              Positioned(
                bottom: 0,
                right: 0,
                child: Text(
                  labelTop,
                  style: const TextStyle(
                      fontSize: 12, color: Color.fromRGBO(97, 30, 240, 1)),
                ),
              ),
            if (labelBottom.isNotEmpty)
              Positioned(
                top: 0,
                left: 0,
                child: Text(
                  labelBottom,
                  style: const TextStyle(
                      fontSize: 12, color: Color.fromRGBO(97, 30, 240, 1)),
                ),
              ),
            if (piece != null)
              Align(
                alignment: Alignment.center,
                child: Transform.scale(
                  scale: 0.8,
                  child: Image.asset(
                    piece!.imagePath,
                    color: piece!.isWhite
                        ? const Color.fromRGBO(244, 247, 250, 1)
                        : const Color.fromRGBO(97, 30, 240, 1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
