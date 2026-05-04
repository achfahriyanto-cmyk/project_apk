import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../models/block.dart';

class PieceSelector extends ConsumerWidget {
  const PieceSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: gameState.availableBlocks.map((block) {
        return Draggable<Block>(
          data: block,
          feedback: _buildBlockWidget(block, 0.5),
          childWhenDragging: _buildBlockWidget(block, 0.3),
          child: _buildBlockWidget(block, 1.0),
        );
      }).toList(),
    );
  }

  Widget _buildBlockWidget(Block block, double opacity) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: 60,
        height: 60,
        color: block.color,
        child: CustomPaint(
          painter: BlockPainter(block.shape),
        ),
      ),
    );
  }
}

class BlockPainter extends CustomPainter {
  final List<Offset> shape;

  BlockPainter(this.shape);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.5);
    for (var offset in shape) {
      canvas.drawRect(
        Rect.fromLTWH(offset.dx * 15, offset.dy * 15, 15, 15),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}