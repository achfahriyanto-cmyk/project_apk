import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../models/block.dart';

class GameBoard extends ConsumerWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      itemCount: 64,
      itemBuilder: (context, index) {
        int row = index ~/ 8;
        int col = index % 8;
        return DragTarget<Block>(
          onAcceptWithDetails: (details) {
            ref.read(gameProvider.notifier).placeBlock(row, col, details.data);
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              margin: const EdgeInsets.all(1.0),
              color: gameState.grid[row][col] == 0 ? Colors.grey[300] : Colors.black,
            );
          },
        );
      },
    );
  }
}