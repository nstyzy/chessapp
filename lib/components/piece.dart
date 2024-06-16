enum ChessPieceType {
  pawm,
  rook,
  knight,
  bishop,
  queen,
  king,
}

class ChessPiece {
  final ChessPieceType type;
  final bool isWhite;
  final String imagePath;

  ChessPiece({
    required this.type,
    required this.isWhite,
    required this.imagePath,
  });

  ChessPiece clone() {
    return ChessPiece(
      type: type,
      isWhite: isWhite,
      imagePath: imagePath,
    );
  }
}