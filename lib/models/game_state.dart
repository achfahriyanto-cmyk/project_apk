import 'block.dart';

class GameState {
  final List<List<int>> grid;
  final int score;
  final int highScore;
  final List<Block> availableBlocks;

  GameState({
    required this.grid,
    required this.score,
    required this.highScore,
    required this.availableBlocks,
  });

  GameState copyWith({
    List<List<int>>? grid,
    int? score,
    int? highScore,
    List<Block>? availableBlocks,
  }) {
    return GameState(
      grid: grid ?? this.grid,
      score: score ?? this.score,
      highScore: highScore ?? this.highScore,
      availableBlocks: availableBlocks ?? this.availableBlocks,
    );
  }

  static GameState initial() {
    return GameState(
      grid: List.generate(8, (_) => List.generate(8, (_) => 0)),
      score: 0,
      highScore: 0,
      availableBlocks: Block.getRandomBlocks().take(3).toList(),
    );
  }
}