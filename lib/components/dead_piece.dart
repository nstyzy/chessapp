import 'package:flutter/material.dart';

class DeadPiece extends StatelessWidget {
  final String imagePath;
  final bool isWhite;
  const DeadPiece({super.key, required this.imagePath, required this.isWhite});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Image.asset(
        imagePath,
        color: isWhite
            ? const Color.fromRGBO(244, 247, 250, 1)
            : const Color.fromRGBO(97, 30, 240, 1),
      ),
    );
  }
}