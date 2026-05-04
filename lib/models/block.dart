import 'dart:ui';

class Block {
  final List<Offset> shape; // Relative positions
  final Color color;

  Block(this.shape, this.color);

  // Predefined blocks
  static List<Block> getRandomBlocks() {
    return [
      // L-shape
      Block([Offset(0, 0), Offset(1, 0), Offset(0, 1), Offset(0, 2)], const Color(0xFFFF0000)),
      // Line
      Block([Offset(0, 0), Offset(1, 0), Offset(2, 0)], const Color(0xFF0000FF)),
      // Square
      Block([Offset(0, 0), Offset(1, 0), Offset(0, 1), Offset(1, 1)], const Color(0xFF00FF00)),
      // T-shape
      Block([Offset(0, 0), Offset(1, 0), Offset(2, 0), Offset(1, 1)], const Color(0xFFFFFF00)),
      // Z-shape
      Block([Offset(0, 0), Offset(1, 0), Offset(1, 1), Offset(2, 1)], const Color(0xFF800080)),
    ];
  }
}