import 'dart:ui';

class Block {
  final List<Offset> shape; // Relative positions
  final Color color;

  Block(this.shape, this.color);

  // Predefined blocks
  static List<Block> getRandomBlocks() {
    final allBlocks = [
      Block([Offset(0, 0), Offset(1, 0), Offset(0, 1), Offset(0, 2)], const Color(0xFFFF0000)), // L
      Block([Offset(0, 0), Offset(1, 0), Offset(2, 0)], const Color(0xFF0000FF)), // Line
      Block([Offset(0, 0), Offset(1, 0), Offset(0, 1), Offset(1, 1)], const Color(0xFF00FF00)), // Square
      Block([Offset(0, 0), Offset(1, 0), Offset(2, 0), Offset(1, 1)], const Color(0xFFFFFF00)), // T
      Block([Offset(0, 0), Offset(1, 0), Offset(1, 1), Offset(2, 1)], const Color(0xFF800080)), // Z
    ];
    allBlocks.shuffle();
    return allBlocks.take(3).toList();
  }
}